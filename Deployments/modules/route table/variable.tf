variable "vpc_id" {
  type = string
}
variable "cidr_block_rt" {
  type = string
  default = "0.0.0.0/0"
}
variable "rt_pub_name" {
  type = string
  default = "public-rt"
}
variable "public_subnet1" {
  type = string
}
variable "ig_gateway" {
  type = string
}
variable "nat_gateway" {
  type = string
}
variable "rt_pvt_name" {
  type = string
  default = "private-rt"
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