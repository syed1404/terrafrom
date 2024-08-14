variable "public_subnet1_cidr" {
 type = string
 default = "10.0.0.0/24"
}
variable "public_subnet2_cidr" {
 type = string
 default = "10.0.1.0/24"
}
variable "private_subnet1_cidr" {
 type = string
 default = "10.0.2.0/24"
}
variable "private_subnet2_cidr" {
 type = string
 default = "10.0.3.0/24"
}
variable "subnet_az1" {
  type = string
  default = "us-east-1a"
}
variable "subnet_az2" {
  type = string
  default = "us-east-1b"
}
variable "subnet_pip_on_launch" {
type = bool
default = true
}
variable "subnet_no_pip_on_launch" {
type = bool
default = false
}
variable "subnet_name1" {
  type = string
  default = "public-subnet-1"
}
variable "subnet_name2" {
  type = string
  default = "public-subnet-2"
}
variable "subnet_name3" {
  type = string
  default = "private-subnet-1"
}
variable "subnet_name4" {
  type = string
  default = "private-subnet-2"
}
variable "vpc_id" {
  type = string
}