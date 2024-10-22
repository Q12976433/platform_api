variable "family" {
  description = "Task Definition Family"
  type        = string
}

variable "execution_role_arn" {
  description = "Execution Role ARN"
  type        = string
}

variable "task_role_arn" {
  description = "Task Role ARN"
  type        = string
}

variable "cpu" {
  description = "Task CPU"
  type        = number
}

variable "memory" {
  description = "Task Memory"
  type        = number
}

variable "container_definitions" {
  description = "Container Definitions in JSON"
  type        = string
}
variable "network_mode" {
    description = "network_mode"
  type        = string
  
}

variable "image" {
  description = "ecs_image"
  type = string
  
}

variable"container_port" {
  description="container_port"
  type=number
} 

variable"host_port"{
    description = "host_port"
    type=number
    }
variable"db_name" {
  type=string
}
variable "db_username" {
  type = string
}
variable "db_host" {
  type = string
}
variable "db_port" {
  type = string
}
variable "db_password" {
  type = string
}
variable "JWT_SECRET" {
  type = string
}
variable "log_group_name" {
  type = string
}
variable "log_region" {
  type = string
  
}
variable "log_stream_prefix" {
  type = string
  
}

