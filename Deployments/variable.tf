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

