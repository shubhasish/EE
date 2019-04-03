variable "region" {
  default = "us-east-1"
}

variable "env" {
  default = "develop"
}

variable "name" {
  default = "EE"
}
provider "aws" {
  region = "${var.region}"
}

data "aws_ami" "jenkins" {

  most_recent = true
  owners = ["self"]
//  name_regex       = "^jenkins-*"
  filter {
    name = "name"
    values = ["jenkins-*"]
  }


}

module "vpc" {
  source          = "../../modules/networking/vpc/"
  name            = "${var.env}-vpc"
  env             = "${var.env}"
  cidr            = "10.5.0.0/16"
  public_subnets  = ["10.5.1.0/24","10.5.2.0/24"]
  private_subnets = ["10.5.11.0/24","10.5.12.0/24"]

  azs = "us-east-1a,us-east-1b"

  region             = "${var.region}"
  zone_id_private    = ""
  nat_gateways_count = 1
}

module "security_groups" {

  source	=	"../../modules/networking/sg/"
  env		= 	"${var.env}"
  region	= 	"${var.region}"
  vpc_id	= 	"${module.vpc.vpc_id}"
}

module "jenkins" {
  source	=	"../../modules/jenkins/"
  env		= 	"${var.env}"
  name = ["jenkins"]
  ami = "${data.aws_ami.jenkins.id}"
  instance_type = "t3.large"

  associate_public_ip= true

//  Create a public key and provide as input parameter
  key_name= "openrisk-virginia-secured"
  security_groups = "${module.security_groups.jenkins_sg_id}"
  subnet_id = "${module.vpc.public_subnets}"
  root_block_volume_type = "gp2"
  root_block_volume_size = 500

  ebs_block_volume_type = "standard"
  ebs_block_device_name = "/dev/sdg"
  ebs_block_volume_size = 20

}

locals {

  # This is the convention we use to know what belongs to each other
  ec2_resources_name = "${var.name}-${var.env}"
}


#----- ECS --------
module "ecs" {
  source = "../../modules/ECS/cluster"
  name   = "${var.name}"
}

module "ec2-profile" {
  source = "../../modules/ECS/instance-profile"
  name   = "${var.name}"
}


#----- ECS  Resources--------

#For now we only use the AWS ECS optimized ami <https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html>
data "aws_ami" "amazon_linux_ecs" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  owners = ["591542846629"]
}

module "ecs_auto_scaling" {
  source = "../../modules/ECS/auto-scaling"

  name = "${local.ec2_resources_name}"

  # Launch configuration
  lc_name = "${local.ec2_resources_name}"

  key_name = "openrisk-virginia-secured"

  image_id             = "${data.aws_ami.amazon_linux_ecs.id}"
  instance_type        = "t2.micro"
  security_groups      = ["${module.security_groups.jenkins_sg_id}"]
  iam_instance_profile = "${module.ec2-profile.this_iam_instance_profile_id}"
  user_data            = "${data.template_file.user_data.rendered}"

  # Auto scaling group
  asg_name                  = "${local.ec2_resources_name}"
  vpc_zone_identifier       = "${module.vpc.private_subnets}"
  health_check_type         = "EC2"
  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0

  tags = [
    {
      key                 = "Environment"
      value               = "${var.env}"
      propagate_at_launch = true
    },
    {
      key                 = "Cluster"
      value               = "${var.name}"
      propagate_at_launch = true
    },
  ]
}

data "template_file" "user_data" {
  template = "${file("${path.module}/user-data.sh")}"

  vars {
    cluster_name = "${var.name}"
  }
}