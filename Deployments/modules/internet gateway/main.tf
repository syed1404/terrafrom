resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id
  tags = {
    Name = var.ig_name
  }
}
output "ig_gateway" {
  value = aws_internet_gateway.main.id
}