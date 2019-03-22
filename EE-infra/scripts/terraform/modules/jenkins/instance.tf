# Create AWS VPC

resource "aws_instance" "instance" {
  count = "${length(var.name)}"
  tags {
    #Name = "${var.region}-${var.env}"
    Name = "${var.name[count.index]}"
    Environment  = "${var.env}"
  }
  ami = "${var.ami}"

  instance_type = "${var.instance_type}"
  associate_public_ip_address = "${var.associate_public_ip}"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${split(",",var.security_groups )}"]
  subnet_id = "${element(var.subnet_id,0)}"
  iam_instance_profile = "${var.iam_instance_profile}"
  root_block_device {
    volume_type = "${var.root_block_volume_type}"
    volume_size = "${var.root_block_volume_size}"
  }
  ebs_block_device {
    device_name = "${var.ebs_block_device_name}"
    volume_type = "${var.ebs_block_volume_type}"
    volume_size = "${var.ebs_block_volume_size}"
  }

}
