# modules/eks/outputs.tf

output "eks_cluster_name" {
  description = "EKS Cluster Name"
  value       = aws_eks_cluster.my_cluster.name
}

output "eks_cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value       = aws_eks_cluster.my_cluster.endpoint
}

output "alb_dns" {
  description = "ALB DNS Name"
  value       = aws_lb.eks_alb.dns_name
}

# modules/eks/outputs.tf

output "sg_id" {
  description = "EKS Node Security Group ID"
  value       = aws_security_group.eks_node_sg.id
}

