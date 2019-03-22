output "jenkins_instance_id" {
  value = "${module.jenkins.instance_id}"
}

output "jenkins_private_ip" {
  value = "${module.jenkins.private_ip}"
}

output "jenkins_public_ip" {
  value = "${module.jenkins.public_ip}"
}

output "jenkins_private_dns" {
  value = "${module.jenkins.private_dns}"
}

output "jenkins_public_dns" {
  value = "${module.jenkins.public_dns}"
}



output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "cidr_block" {
  value = "${module.vpc.cidr_block}"
}

output "public_subnets" {
  value = "${module.vpc.public_subnets}"
}

output "public_subnets_cidr" {
  value = "${module.vpc.public_subnets_cidr}"
}

output "public_subnets_az" {
  value = "${module.vpc.public_subnets_az}"
}

output "private_subnets" {
  value = "${module.vpc.private_subnets}"
}

output "private_subnets_cidr" {
  value = "${module.vpc.private_subnets_cidr}"
}

output "public_route_table_id" {
  value = "${module.vpc.public_route_table_id}"
}

output "private_route_table_ids" {
  value = "${module.vpc.private_route_table_ids}"
}

output "nat_eips" {
  value = "${module.vpc.nat_eips}"
}

output "jenkins_sg_id" {
  value = "${module.security_groups.jenkins_sg_id}"
}