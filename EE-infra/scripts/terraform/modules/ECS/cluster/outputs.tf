output "ecs_cluster_id" {
  value = "${element(concat(aws_ecs_cluster.ecs.*.id, list("")), 0)}"
}

output "ecs_cluster_arn" {
  value = "${element(concat(aws_ecs_cluster.ecs.*.arn, list("")), 0)}"
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = "${var.name}"
}