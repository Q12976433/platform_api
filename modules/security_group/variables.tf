variable "vpc_id" {
  description = "The VPC ID to associate with the security groups"
  type        = string
 # default     = module.vpc.vpc_id
}

variable "rds_security_group_name" {
  description = "The name of the RDS security group"
  type        = string
}

variable "alb_security_group_name" {
  description = "The name of the ALB security group"
  type        = string
}

variable "ecs_security_group_name" {
  description = "The name of the ECS security group"
  type        = string
}

variable "ecs_ingress_port" {
  description = "The port for ECS ingress traffic"
  type        = number
}
