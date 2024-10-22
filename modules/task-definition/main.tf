resource "aws_cloudwatch_log_group" "my_log_group" {
  name              = "/ecs/myapp/tf"
  retention_in_days = 7
}


resource "aws_ecs_task_definition" "my_task" {
  family                   = var.family
  network_mode             = var.network_mode
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn

  cpu                      = var.cpu
  memory                   = var.memory
  requires_compatibilities = ["FARGATE"]

  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }

  container_definitions = jsonencode([
    {
      name           = "test1"
      image          = var.image
      cpu            = 0
      essential      = true
      portMappings = [
        {
          containerPort = var.container_port
         # hostPort      = var.host_port
          protocol      = "tcp"
        }
      ]
      environment = [
        { name = "DB_NAME", value = var.db_name },
        { name = "DB_USERNAME", value = var.db_username },
        { name = "DB_HOST", value = var.db_host },  # 传递的RDS地址
        { name = "DB_PORT", value = var.db_port },
        { name = "DB_PASSWORD", value = var.db_password },
        { name = "JWT_SECRET", value = var.JWT_SECRET}
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-create-group"   = "true"
          "awslogs-group"          = aws_cloudwatch_log_group.my_log_group.name
          "awslogs-region"         = var.log_region
          "awslogs-stream-prefix"  = var.log_stream_prefix
        }
      }
    }
  ])
}
