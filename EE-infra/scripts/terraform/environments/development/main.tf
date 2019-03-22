variable "region" {
  default = "us-east-1"
}

variable "env" {
  default = "develop"
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
    values = ["openrisk-jenkins-*"]
  }


}

module "vpc" {
  source          = "../../modules/networking/vpc/"
  name            = "${var.env}-vpc"
  env             = "${var.env}"
  cidr            = "10.5.0.0/16"
  public_subnets  = ["10.5.1.0/24"]
  private_subnets = ["10.5.2.0/24"]

  azs = "us-east-1a"

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
  key_name= "##Some Key##"
  security_groups = "${module.security_groups.jenkins_sg_id}"
  subnet_id = "${module.vpc.public_subnets}"
  root_block_volume_type = "gp2"
  root_block_volume_size = 500

  ebs_block_volume_type = "standard"
  ebs_block_device_name = "/dev/sdg"
  ebs_block_volume_size = 20

}