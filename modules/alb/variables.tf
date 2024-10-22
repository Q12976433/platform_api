variable "alb_name" {
  description = "Application Load Balancer Name"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for ALB"
  type        = list(string)
}

variable "security_groups" {
  description = "Security Group ID for ALB"
  type        = list(string)
  #default = [ module.security_group.alb_security_group_id ]
}




variable "target_group_name" {
  description = "Target Group Name"
  type        = string
}

variable "target_group_port" {
  description = "Target Group Port"
  type        = number
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

# Health check variables
variable "health_check_interval" {
  description = "Health Check Interval"
  type        = number
}

variable "health_check_path" {
  description = "Health Check Path"
  type        = string
  default = "/healthcheck"
}

variable "health_check_port" {
  description = "Health Check Port"
  type        = string
}

variable "health_check_timeout" {
  description = "Health Check Timeout"
  type        = number
}

variable "healthy_threshold" {
  description = "Healthy Threshold"
  type        = number
}

variable "unhealthy_threshold" {
  description = "Unhealthy Threshold"
  type        = number
}

variable "health_check_matcher" {
  description = "Health Check Matcher"
  type        = string
}

variable "listener_port" {
  description = "Listener Port for ALB"
  type        = number
}
