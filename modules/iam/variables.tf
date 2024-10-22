variable "ecs_task_role_name" {
  description = "Name of the ECS task role"
  type        = string
}

variable "ecs_task_execution_role_name" {
  description = "Name of the ECS task execution role"
  type        = string
}

variable "eks_cluster_role_name" {
  description = "Name of the EKS cluster role"
  type        = string
}

variable "eks_node_role_name" {
  description = "Name of the EKS node group role"
  type        = string
}
variable "ecs_task_role_policy" {
  description = "ECS task role policy"
  type        = string
}

variable "ecs_task_role" {
  description = "ECS task role"
  type        = string
}