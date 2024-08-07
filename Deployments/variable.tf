variable "vpc_cidr" {
    description = "The CIDR value of VPC"
    type = string
    default = "10.0.0.0/16"
  }
variable "vpc_name" {
    description = "The name of VPC"
    type = string
    default = "test"
}


variable "vpc_public_subnet" {
    description = "The public subnet of VPC"
    type = string
    default = "10.0.0.0/24"
}
variable "vpc_public_subnet_name" {
    description = "The name of public subnet of VPC"
    type = string
    default = "public test"
  
}
variable "vpc_public_subnet1" {
    description = "The public subnet of VPC"
    type = string
    default = "10.0.2.0/24"
}
variable "vpc_public_subnet_name1" {
    description = "The name of public subnet of VPC"
    type = string
    default = "public test1"
  
}

variable "vpc_private_subnet" {
    description = "The private subnet of VPC"
    type = string
    default = "10.0.1.0/24"
}
variable "vpc_private_subnet_name" {
    description = "The name of private subnet of VPC"
    type = string
    default = "private test"
  
}

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
    default = [ {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_block = [ "0.0.0.0/0" ]
    },
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