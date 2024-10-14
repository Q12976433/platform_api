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
/*
variable "task_definition_arn" {
  description = "Task Definition ARN"
  type        = string
}
*/
variable "desired_count" {
  description = "Desired number of tasks"
  type        = number
  default     = 1  # 预设任务数量
}
/*
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
*/
variable "container_name" {
  description = "ECS Container Name"
  type        = string
  default     = "my-container"  # 预设容器名称
}

variable "container_port" {
  description = "ECS Container Port"
  type        = number
  default     = 3000  # 预设端口号
}


variable "image" {
  description = "The container image to use for the ECS task"
  type        = string
  default = "339713093281.dkr.ecr.us-east-1.amazonaws.com/test1:823f190f865a132e727d7d0780e1686b0c9901b2"
}

variable "ecs_task_role" {
  type    = string
  default     = "ecs_task_role"  # 自定义你的 ECS 任务角色名称
}

variable "ecs_task_role_policy" {
  description = "IAM policy for the ECS task role"
  type        = string
  default     = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "cloudwatch:PutMetricData"
      ],
      "Resource": "*"
    }
  ]
}
POLICY
}
