output "alb_security_group_id" {
  value       = aws_security_group.alb_sg.id
  description = "The ID of the ALB security group"
}

output "rds_security_group_id" {
  value       = aws_security_group.bqcore_sg.id
  description = "The ID of the RDS security group"
}



output "ecs_security_group_id" {
  value       = aws_security_group.ecs_sg.id
  description = "The ID of the ECS security group"
}

