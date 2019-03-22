#Output from the Module to get in statefile so that we can reference it later                          #
#------------------------------------------------------------------------------------------------------#

output "instance_id" {
  #ue = "${aws_instance.jenkins.id}"
  value = ["${aws_instance.instance.*.id}"]
}
  #value = "${element(concat(aws_instance.jenkins.*.id, list("")), 0)}"

output "public_dns" {
  #value = "${aws_instance.jenkins.public_dns}"
  value = ["${aws_instance.instance.*.public_dns}"]
}

output "public_ip" {
  #value = "${aws_instance.jenkins.public_ip}"
  value = ["${aws_instance.instance.*.public_ip}"]
}

output "private_dns" {
  #value = "${aws_instance.jenkins.private_dns}"
  value = ["${aws_instance.instance.*.private_dns}"]
}

output "private_ip" {
  #value = "${aws_instance.jenkins.private_ip}"
  value = ["${aws_instance.instance.*.private_ip}"]

}

output "public_url" {
  value = ["${aws_route53_record.rotue_entry.*.name}"]
}

