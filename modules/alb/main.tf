resource "aws_lb" "ecs_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = var.security_groups
}

resource "aws_lb_target_group" "ecs_tg" {
  name     = var.target_group_name
  port     =  3000  #var.target_group_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    #enabled             = true
    interval            = 30#var.health_check_interval
    path                =  "/healthcheck"#var.hyealth_check_path
   # port                = var.health_check_port
    protocol            = "HTTP"
    timeout             = 5 #var.health_check_timeout
    healthy_threshold   = 2#var.healthy_threshold
    unhealthy_threshold = 2#var.unhealthy_threshold
    matcher             = "200"#var.health_check_matcher
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              ="3000"# var.listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
}
