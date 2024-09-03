resource "aws_lb" "test" {
  name               = var.alb_name
  internal           = var.external
  load_balancer_type = var.alb_type
  security_groups    = [var.alb_sg]
  subnets            = [var.public_subnet1, var.public_subnet2]
  enable_deletion_protection = false
  enable_cross_zone_load_balancing = true
}
 
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.test.arn
  port = var.alb_listener80.port
  protocol = var.alb_listener80.protocol
 
  default_action {
    type = var.action_listener
    target_group_arn = aws_lb_target_group.test.arn
    }
  }
 
resource "aws_lb_target_group" "test" {
  name        = var.aws_lb_target_group.name
  port        = var.aws_lb_target_group.port
  protocol    = var.aws_lb_target_group.protocol
  vpc_id      = var.vpc_id
  target_type = var.aws_lb_target_group.target_type  # or "ip" depending on your setup
 
  health_check {
    path                 = var.alb_health.path
    interval             = var.alb_health.interval
    timeout              = var.alb_health.timeout
    healthy_threshold    = var.alb_health.healthy_threshold
    unhealthy_threshold  = var.alb_health.unhealthy_threshold
  }
}
resource "aws_lb_target_group_attachment" "test" {
  count = 1
  target_group_arn   = aws_lb_target_group.test.arn
  target_id          = aws_lb.internal.id
  port               = 80  # Port that the target group listens on
}

#internal load balancer
resource "aws_lb" "internal" {
  name               = var.ilb_name
  internal           = var.internal
  load_balancer_type = var.alb_type
  security_groups    = [var.ilb_sg]
  subnets            = [var.private_subnet1, var.private_subnet2]
  enable_deletion_protection = false
  enable_cross_zone_load_balancing = true
}
 
resource "aws_lb_listener" "http_ilb" {
  load_balancer_arn = aws_lb.internal.arn
  port = var.alb_listener80.port
  protocol = var.alb_listener80.protocol
 
  default_action {
    type = var.action_listener
    target_group_arn = aws_lb_target_group.ilb.arn
    }
  }
 
resource "aws_lb_target_group" "ilb" {
  name        = var.aws_ilb_target_group.name
  port        = var.aws_ilb_target_group.port
  protocol    = var.aws_ilb_target_group.protocol
  vpc_id      = var.vpc_id
  target_type = var.aws_ilb_target_group.target_type  # or "ip" depending on your setup
 
  health_check {
    path                 = var.alb_health.path
    interval             = var.alb_health.interval
    timeout              = var.alb_health.timeout
    healthy_threshold    = var.alb_health.healthy_threshold
    unhealthy_threshold  = var.alb_health.unhealthy_threshold
  }
}
resource "aws_lb_target_group_attachment" "internal" {
  count = 1
  target_group_arn   = aws_lb_target_group.test.arn
  target_id          = var.ec2_web1
  port               = 80  # Port that the target group listens on
}