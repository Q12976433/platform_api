terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      // Ensure the version is valid and compatible
    }
  }
}

module "vpc" {
  source = "./modules/vpc"

  cidr_block          = "10.0.0.0/16"
  vpc_name            = "My-VPC"

  public_subnet_1_cidr = "10.0.5.0/24"
  public_subnet_2_cidr = "10.0.6.0/24"
  public_az_1          = "us-east-1a"
  public_az_2          = "us-east-1b"

  private_subnet_1_cidr = "10.0.7.0/24"
  private_subnet_2_cidr = "10.0.8.0/24"
  private_az_1          = "us-east-1a"
  private_az_2          = "us-east-1b"
}

output "subnet_ids" {
  value = module.vpc.private_subnet_ids
}



module "security_group" {
  source                  = "./modules/security_group"
  vpc_id                  = module.vpc.vpc_id
  rds_security_group_name = "rds-sg"
  alb_security_group_name = "alb-security-group"
  ecs_security_group_name = "ecs-security-group"
  ecs_ingress_port        = 3000
}


output "vpc_id" {
  value = module.vpc.vpc_id
}
output "rds_security_group_id"{
  value = module.security_group.rds_security_group_id
}






module "iam" {
  source                       = "./modules/iam"
  ecs_task_role_name            = "ecs_task_role"
  ecs_task_role               =   var.ecs_task_role
  ecs_task_execution_role_name  = "ecs_task_execution_role"
  eks_cluster_role_name         = "eks_cluster_role"
  eks_node_role_name            = "eks_node_role"
  
  ecs_task_role_policy = var.ecs_task_role_policy
}
/*
module "eks" {
  source               = "./modules/eks"
  cluster_name         = "my-cluster"
  cluster_role_arn     = module.iam.eks_cluster_role_arn
  node_role_arn        = module.iam.eks_node_role_arn
  subnet_ids           = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  public_subnets       = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  eks_node_sg_id       = module.eks.sg_id
  alb_security_group_id = aws_security_group.alb_sg.id
  alb_name             = "eks-alb"
  vpc_id               = aws_vpc.bqcore_vpc.id
  target_group_name    = "eks-tg"
  sg_name = "eks-node-sg"
}
*/

module "rds" {
  source = "./modules/rds"
  # RDS Parameter Group Configurations
  parameter_group_name    = "bqcore-param-group"
  parameter_group_family  = "postgres16"
  force_ssl_value         = "0"
  # RDS Instance Configurations
  engine            = "postgres"
  engine_version    = "16.2"
  instance_class    = "db.t3.micro"
  allocated_storage = 5
  storage_type      = "gp2"
  db_name           = "bqCore"
  username          = "postgres"
  password          = "CORE_ADMIN"
  #JWT_SECRET       = "hello_beequent"
  vpc_security_group_ids = [module.security_group.rds_security_group_id]
  publicly_accessible = true
  skip_final_snapshot  = true
  #public_subnet_ids = module.vpc.public_subnet_ids  
  # DB Subnet Group
  db_subnet_group_name = "bq-subnet-group"
  subnet_ids = module.vpc.public_subnet_ids

}

output "db_endpoint" {
  value = module.rds.db_address
}


# Example of using outputs

module "task-definition" {
  source = "./modules/task-definition"

  family                = "my-vpc"
  network_mode          = "awsvpc"
  execution_role_arn    = module.iam.ecs_task_execution_role_arn
  task_role_arn         =  module.iam.ecs_task_role_arn 
  cpu                   = 2048
  memory                = 6144
  log_group_name        = "/ecs/tf-ver"       # 添加 log_group_name
  log_stream_prefix     = "ecs"                   # 添加 log_stream_prefix
  db_name               = "bqCore"                # 添加 db_name
  db_host               = module.rds.db_address  # 添加 db_host
  db_username           = "postgres"              # 添加 db_username
  db_port               = 5432                    # 添加 db_port
  db_password           = "CORE_ADMIN"            # 添加 db_password
  JWT_SECRET                = "hello_beeQuant"        # 添加 jwt_secret
  container_port        = 3000                    # 添加 container_port
  host_port             = 3000         
  log_region = "us-east-1"           # 添加 host_port
  image                 = var.image

  container_definitions = jsonencode([{
    name      = "my-container"
    
    cpu       = 1024
    memory    = 3072
    portMappings = [{
      containerPort = 3000
      hostPort      = 3000
      appprotocol  = "http2"
      protocol      = "TCP"
    }]
    environment = [
      {
        name  = "DB_NAME"
        value = "bqCore"
      },
      {
        name  = "DB_USERNAME"
        value = "postgres"
      },
      {
        name  = "DB_HOST"
        value = module.rds.db_address
      },
      {
        name  = "DB_PORT"
        value = 5432
      },
      {
        name  = "DB_PASSWORD"
        value = "CORE_ADMIN"
      },
      {
        name  = "JWT_SECRET"
        value = "hello_beeQuant"
      }
    ]
  }])
}

module "ecs" {
  source              = "./modules/ecs"  # 这是模块的相对路径
  cluster_name        = "my-cluster"
  service_name        = "my-service"
  target_group_arn    = module.alb.target_group_arn  #
  task_definition_arn = module.task-definition.task_definition_arn
  desired_count       = var.desired_count 
  subnet_ids          = module.vpc.public_subnet_ids
  subnets = module.vpc.public_subnet_ids
  security_group_id   = module.security_group.ecs_security_group_id
  container_name      = var.container_name
  container_port      = var.container_port
}





module "alb" {
  source                 = "./modules/alb"
  alb_name               = "my-alb"
  subnet_ids             = module.vpc.public_subnet_ids
  #security_group_id      = module.security_group.alb_security_group_id
  #security_groups = [module.security_group.alb_security_group_id]
  security_groups = [module.security_group.alb_security_group_id]
 # security_groups = module.security_group.alb_security_group_id
 
  target_group_name      = "my-target-group"
  target_group_port      =  3000#3000
  vpc_id                 = module.vpc.vpc_id
  listener_port          = 3000
  health_check_interval  = 30
  health_check_path      = "/healthcheck"
  health_check_port      = "traffic-port"
  health_check_timeout   = 5
  healthy_threshold      = 3
  unhealthy_threshold    = 3
  health_check_matcher   = "200"
}
