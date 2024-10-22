output "ecs_cluster_id" {
  value = aws_ecs_cluster.my_cluster.id
}

output "ecs_service_id" {
  value = aws_ecs_service.my_service.id
}
