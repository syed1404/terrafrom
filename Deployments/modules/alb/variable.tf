variable "elb_name" {
  type = string
  default = "elb-test"
}
variable "ilb_name" {
  type = string
  default = "ilb-name"
}
variable "external" {
  type = bool
  default = false
}
variable "internal" {
  type = bool
  default = true
}
variable "lb_type" {
  type = string
  default = "application"
}
variable "lb_type1" {
  type = string
  default = "network"
}
variable "alb_sg" {
  type = string
}
variable "ailb_sg" {
  type = string
}
variable "public_subnet1" {
  type = string
}
variable "public_subnet2" {
  type = string
}
variable "private_subnet1" {
  type = string
}
variable "private_subnet2" {
  type = string
}
variable "elb_target_group" {
  type = object({
    name = string
    port = string
    protocol = string
    target_type = string
  })
  default = {
    name = "elb-tg"
    port = "80"
    protocol = "TCP"
    target_type = "alb"
  }
}

variable "ilb_target_group" {
  type = object({
    name = string
    port = string
    protocol = string
    target_type = string
  })
  default = {
    name = "ilb-tg"
    port = "80"
    protocol = "HTTP"
    target_type = "instance"
  }
}
variable "vpc_id" {
  type = string
}
variable "action_listener" {
  description = "Listener action"
  type        = string
  default     = "forward"
}
variable "alb_health" {
  description = "Health check of ALB"
  type = object({
    path                = string
    interval            = number
    timeout             = number
    healthy_threshold   = number
    unhealthy_threshold = number
  })
  default = {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}
variable "web1" {
  type = string
}