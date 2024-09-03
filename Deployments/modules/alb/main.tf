resource "aws_alb" "external" {
  name = var.elb_name
  internal = var.external
  load_balancer_type = var.lb_type1
  security_groups = [ var.alb_sg ]
  subnets = [ var.public_subnet1, var.public_subnet2 ]
  enable_deletion_protection = false
  enable_cross_zone_load_balancing = true
}

resource "aws_alb" "internal" {
  name = var.ilb_name
  internal = var.internal
  load_balancer_type = var.lb_type
  security_groups = [ var.ailb_sg ]
  subnets = [ var.private_subnet1, var.private_subnet2 ]
  enable_deletion_protection = false
  enable_cross_zone_load_balancing = true
}
resource "aws_lb_target_group" "elb_target_group" {
  name = var.elb_target_group.name
  port = var.elb_target_group.port
  protocol = var.elb_target_group.protocol
  target_type = var.elb_target_group.target_type
  vpc_id = var.vpc_id

  health_check {
    path                 = var.alb_health.path
    interval             = var.alb_health.interval
    timeout              = var.alb_health.timeout
    healthy_threshold    = var.alb_health.healthy_threshold
    unhealthy_threshold  = var.alb_health.unhealthy_threshold
  }
}
resource "aws_lb_target_group" "ilb_target_group" {
  name = var.ilb_target_group.name
  port = var.ilb_target_group.port
  protocol = var.ilb_target_group.protocol
  target_type = var.ilb_target_group.target_type
  vpc_id = var.vpc_id

  health_check {
    path                 = var.alb_health.path
    interval             = var.alb_health.interval
    timeout              = var.alb_health.timeout
    healthy_threshold    = var.alb_health.healthy_threshold
    unhealthy_threshold  = var.alb_health.unhealthy_threshold
  }
}
resource "aws_lb_listener" "elb_listener" {
  default_action {
    target_group_arn = aws_lb_target_group.elb_target_group.arn
    type = var.action_listener
  }
  load_balancer_arn = aws_alb.external.arn
  port = var.elb_target_group.port
  protocol = var.elb_target_group.protocol
  }
  resource "aws_lb_listener" "ilb_listener" {
  default_action {
    target_group_arn = aws_lb_target_group.ilb_target_group.arn
    type = var.action_listener
  }
  load_balancer_arn = aws_alb.internal.arn
   port = var.ilb_target_group.port
   protocol = var.ilb_target_group.protocol
  }
  resource "aws_lb_target_group_attachment" "test" {
  count = 1
  target_group_arn   = aws_lb_target_group.elb_target_group.arn
  target_id          = aws_alb.internal.id
  port               = 80  # Port that the target group listens on
}
resource "aws_lb_target_group_attachment" "internal" {
  count = 1
  target_group_arn   = aws_lb_target_group.ilb_target_group.arn
  target_id          = var.web1
  port               = 80  # Port that the target group listens on
}