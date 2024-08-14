# Public Subnet
resource "aws_subnet" "public_subnet1" {
 vpc_id = var.vpc_id
  cidr_block = var.public_subnet1_cidr
  availability_zone = var.subnet_az1
  map_public_ip_on_launch = var.subnet_pip_on_launch
  tags = {
    name = var.subnet_name1
  }
}
resource "aws_subnet" "public_subnet2" {
  vpc_id = var.vpc_id
  cidr_block = var.public_subnet2_cidr
  availability_zone = var.subnet_az2
  map_public_ip_on_launch = var.subnet_pip_on_launch
  tags = {
    name = var.subnet_name2
  }
}

#private subnet
resource "aws_subnet" "private_subnet1" {
  vpc_id = var.vpc_id
  cidr_block = var.private_subnet1_cidr
  availability_zone = var.subnet_az1
  map_public_ip_on_launch = var.subnet_no_pip_on_launch
  tags = {
    name = var.subnet_name3
  }
}
resource "aws_subnet" "private_subnet2" {
  vpc_id = var.vpc_id
  cidr_block = var.private_subnet2_cidr
  availability_zone = var.subnet_az2
  map_public_ip_on_launch = var.subnet_no_pip_on_launch
  tags = {
    name = var.subnet_name4
  }
}
