variable "alb_name" {
  description = "Name of ALB"
  type = string
  default = "test-alb"
}
variable "external" {
    description = "Scheme of ALB"
    type = bool
    default = false 
}
variable "internal" {
    description = "Scheme of ALB"
    type = bool
    default = true 
}
variable "alb_type" {
  description = "Type of LB"
  type = string
  default = "application"
}
#variable for listener & Target group
variable "alb_listener80" {
  description = "Ports to listen"
  type = object({
    port = number
    protocol = string
  })
  default = {
    port = 80
    protocol = "HTTP"
  }
}
variable "action_listener" {
  description = "Listener action"
  type = string
  default = "forward"
}
variable "alb_health" {
  description = "health check of ALB"
  type = object({
    path                 = string
    interval             = number
    timeout              = number
    healthy_threshold    = number
    unhealthy_threshold  = number
  })
  default = {
    path                 = "/"
    interval             = 30
    timeout              = 5
    healthy_threshold    = 3
    unhealthy_threshold  = 3
  }
}
variable "aws_lb_target_group" {
  description = "Target group for ALB"
  type = object({
    name        = string
    port        = number
    protocol    = string
    target_type = string
  })
  default = {
    name = "test-target-group"
    port = 80
    protocol = "HTTP"
    target_type = "instance"
  }
}
variable "vpc_id" {
  type = string
}
variable "ec2_web1" {
  type = string
}
variable "public_subnet1" {
  type = string
}
variable "public_subnet2" {
  type = string
}
variable "alb_sg" {
  type = string
}
variable "ilb_sg" {
  type = string
}
variable "private_subnet1" {
  type = string
}
variable "private_subnet2" {
  type = string
}
variable "ilb_name" {
  type = string
  default = "ilb"
}
variable "aws_ilb_target_group" {
  description = "Target group for ALB"
  type = object({
    name        = string
    port        = number
    protocol    = string
    target_type = string
  })
  default = {
    name = "ilb-target-group"
    port = 80
    protocol = "HTTP"
    target_type = "alb"
  }
}