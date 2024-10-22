# modules/eks/variables.tf

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "cluster_role_arn" {
  description = "Role ARN for the EKS cluster"
  type        = string
}

variable "node_role_arn" {
  description = "Role ARN for the EKS node group"
  type        = string
}

variable "subnet_ids" {
  description = "Private Subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "public_subnets" {
  description = "Public Subnets for ALB"
  type        = list(string)
}

variable "eks_node_sg_id" {
  description = "Security Group ID for EKS nodes"
  type        = string
}

variable "alb_security_group_id" {
  description = "Security Group ID for the ALB"
  type        = string
}

variable "alb_name" {
  description = "ALB Name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "target_group_name" {
  description = "Target Group Name"
  type        = string
}
# modules/eks/variables.tf

variable "sg_name" {
  description = "Security Group Name"
  type        = string
  default     = "eks-node-sg"
}


