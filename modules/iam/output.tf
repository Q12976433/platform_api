output "task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}
output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster.arn
}

output "eks_node_role_arn" {
  value = aws_iam_role.eks_node_role.arn
}
output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
  description = "The ARN of the ECS task role"
}

output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
  description = "The ARN of the ECS task execution role"
}
