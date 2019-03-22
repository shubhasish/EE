#Output from the Module to get in statefile so that we can reference it later                          #
#------------------------------------------------------------------------------------------------------#

output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "cidr_block" {
  value = "${aws_vpc.vpc.cidr_block}"
}

output "public_subnets" {
  value = ["${aws_subnet.public.*.id}"]
}

output "public_subnets_cidr" {
  value = ["${aws_subnet.public.*.cidr_block}"]
}

output "public_subnets_az" {
  value = ["${aws_subnet.public.*.availability_zone}"]
}

output "private_subnets" {
  value = ["${aws_subnet.private.*.id}"]
}

output "private_subnets_cidr" {
  value = ["${aws_subnet.private.*.cidr_block}"]
}

output "private_subnets_az" {
  value = ["${aws_subnet.private.*.availability_zone}"]
}

output "public_route_table_id" {
  value = "${aws_route_table.public.*.id}"
}

output "private_route_table_ids" {
  value = ["${aws_route_table.private.*.id}"]
}

output "nat_eips" {
  value = ["${aws_eip.nat.*.public_ip}"]
}


#output "flow_log_id" {
#  value = "${aws_flow_log.flow_log.*.id}"
#}
#
#output "flow_log_cwl_arn" {
#  value = "${aws_cloudwatch_log_group.flow_log_group.*.arn}"
#}
#
#output "flow_log_cwl_name" {
#  value = "${aws_cloudwatch_log_group.flow_log_group.*.name}"
#}


