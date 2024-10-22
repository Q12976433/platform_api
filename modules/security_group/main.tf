# RDS Security Group
resource "aws_security_group" "bqcore_sg" {
  name        = var.rds_security_group_name
  description = "Allow PostgreSQL traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS Security Group"
  }
}

# ALB Security Group
resource "aws_security_group" "alb_sg" {
  name        = var.alb_security_group_name
  description = "Security group for the Application Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALB Security Group"
  }
}

# ECS Security Group
resource "aws_security_group" "ecs_sg" {
  name        = var.ecs_security_group_name
  description = "Security group for ECS instances"
  vpc_id      = var.vpc_id
/*
  ingress {
    from_port   = var.ecs_ingress_port
    to_port     = var.ecs_ingress_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
*/

  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow outbound traffic to RDS"
  }

  tags = {
    Name = "ECS Security Group"
  }
}
