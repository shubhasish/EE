#Output from the Module to get in statefile so that we can reference it later                          #
#------------------------------------------------------------------------------------------------------#

output "instance_id" {
  value = ["${aws_instance.instance.*.id}"]
}

output "public_dns" {
  value = ["${aws_instance.instance.*.public_dns}"]
}

output "public_ip" {
  value = ["${aws_instance.instance.*.public_ip}"]
}

output "private_dns" {
  value = ["${aws_instance.instance.*.private_dns}"]
}

output "private_ip" {
  value = ["${aws_instance.instance.*.private_ip}"]

}


