# modules/eks/main.tf

resource "aws_eks_cluster" "my_cluster" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [var.eks_node_sg_id]
  }
}

resource "aws_eks_node_group" "my_node_group" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = "my-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t3.large"]
}

resource "aws_lb" "eks_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]
  subnets            = var.public_subnets
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "eks_tg" {
  name        = var.target_group_name
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

   health_check {
    enabled             = true
    interval            = 30
    path                = "/healthcheck"
    port                = "3000"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_listener" "eks_front_end" {
  load_balancer_arn = aws_lb.eks_alb.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.eks_tg.arn
  }
}
# modules/eks/main.tf

# modules/eks/eks-sg.tf
resource "aws_security_group" "eks_node_sg" {
  name        = var.sg_name
  description = "EKS Node security group"
  vpc_id      = var.vpc_id

  # Allow inbound traffic on all ports from within the security group
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_name
  }
}



# 其他 EKS 相关的资源
