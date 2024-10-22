
/*
output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster.arn
}

output "eks_node_role_arn" {
  value = aws_iam_role.eks_node_role.arn
}
*/
output "task_definition_arn" {
  value = aws_ecs_task_definition.my_task.arn
}
