# VPC creation
resource "aws_vpc" "test-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    name = var.vpc_name
  }
}

output "vpc_id" {
  value = aws_vpc.test-vpc.id
}
