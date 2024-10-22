variable "cluster_name" {
  description = "ECS Cluster Name"
  type        = string
  default     = "my-cluster"  # 预设默认值
}

variable "service_name" {
  description = "ECS Service Name"
  type        = string
  default     = "my-service"  # 预设默认值
}

variable "task_definition_arn" {
  description = "Task Definition ARN"
  type        = string
}

variable "desired_count" {
  description = "Desired number of tasks"
  type        = number
  default     = 1  # 预设任务数量
}

variable "subnet_ids" {
  description = "Subnets for ECS service"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for ECS service"
  type        = string
}

variable "target_group_arn" {
  description = "Target Group ARN for ALB"
  type        = string
}

variable "container_name" {
  description = "ECS Container Name"
  type        = string
  default     = "test1"  # 预设容器名称
}

variable "container_port" {
  description = "ECS Container Port"
  type        = number
  default     = 3000 # 预设端口号
}

variable "subnets" {
  description = "subnets"
  type = list(string)
  
}