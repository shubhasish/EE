resource "aws_ecs_cluster" "ecs" {
  count = "${var.create_ecs ? 1 : 0}"

  name = "${var.name}"
 # tags = "${var.tags}"
}
