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
output "public_subnet1" {
  value = aws_subnet.public_subnet1.id
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
output "public_subnet2" {
  value = aws_subnet.public_subnet2.id
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
output "private_subnet1" {
  value = aws_subnet.private_subnet1.id
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
output "private_subnet2" {
  value = aws_subnet.private_subnet2.id
}
