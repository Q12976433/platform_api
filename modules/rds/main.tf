# Custom DB Parameter Group
resource "aws_db_parameter_group" "bqcore_param_group" {
  name   = var.parameter_group_name
  family = var.parameter_group_family

  parameter {
    name  = "rds.force_ssl"
    value = var.force_ssl_value
  }
}

# DB Subnet Group
resource "aws_db_subnet_group" "bqcore_db_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids

  tags = {
    Name = var.db_subnet_group_name
  }
}

# RDS PostgreSQL Instance
resource "aws_db_instance" "bqcore_db2" {
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type

  db_name = var.db_name
  username = var.username
  password = var.password
  port     = var.db_port

  db_subnet_group_name     = aws_db_subnet_group.bqcore_db_subnet_group.name
  vpc_security_group_ids   = var.vpc_security_group_ids
  parameter_group_name     = aws_db_parameter_group.bqcore_param_group.name

  publicly_accessible = var.publicly_accessible
  skip_final_snapshot = var.skip_final_snapshot

    lifecycle {
    ignore_changes = [
      parameter_group_name,     # 忽略 parameter group 的更改
      db_subnet_group_name      # 忽略 subnet group 的更改
    ]
  }
}
