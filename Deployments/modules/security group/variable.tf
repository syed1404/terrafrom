variable "sg_name" {
  description = "Name of security group"
  type = string
  default = "lb-security-group"
}
variable "ingress_rule" {
    description = "List of inbound rule"
    type = list(object({
      from_port = number
      to_port = number
      protocol = string
      cidr_block = list(string)
    }))
    default = [ {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_block = [ "0.0.0.0/0" ]
    }]
}
variable "egress_rule" {
    description = "List of outbound rule"
    type = list(object({
      from_port = number
      to_port = number
      protocol = string
      cidr_block = list(string)
    }))
    default = [ {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_block = [ "0.0.0.0/0" ]
    } ]
  
}

variable "sg_name1" {
  description = "Name of security group"
  type = string
  default = "instance-security-group"
}
variable "ingress_rule1" {
    description = "List of inbound rule"
    type = list(object({
      from_port = number
      to_port = number
      protocol = string
      cidr_block = list(string)
    }))
    default = [
    {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_block = [ "0.0.0.0/0" ]  
    } ]
}
variable "egress_rule1" {
    description = "List of outbound rule"
    type = list(object({
      from_port = number
      to_port = number
      protocol = string
      cidr_block = list(string)
    }))
    default = [ {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_block = [ "0.0.0.0/0" ]
    } ]
  
}
variable "allow_lb_to_ec2" {
    description = "Allow traffic form ALB to EC2"
    type = object({
      from_port = number
      to_port = number
      protocol = string
    })
    default = {
      from_port = 80
      to_port = 80
      protocol = "tcp"
    }
}
variable "vpc_id" {
    type = string
}

variable "rule_type" {
  description = "whether it is inbound or outbound"
  type = string
  default = "ingress"
}

variable "sg_name2" {
  description = "Name of security group"
  type = string
  default = "instance-security-group2"
}

variable "allow_ec2_to_ec2" {
    description = "Allow traffic form ALB to EC2"
    type = object({
      from_port = number
      to_port = number
      protocol = string
    })
    default = {
      from_port = 22
      to_port = 22
      protocol = "tcp"
    }
}
variable "ec2_web2_private_ip" {
  type = string
}

variable "sg_name3" {
  description = "Name of security group"
  type = string
  default = "ilb-security-group"
}

variable "sg_name4" {
  type = string
  default = "rds-security-group"
}