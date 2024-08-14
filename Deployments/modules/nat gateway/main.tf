resource "aws_eip" "nat_ip" {
  domain = var.domain
}
 
resource "aws_nat_gateway" "public_nat" {
allocation_id = aws_eip.nat_ip.id
subnet_id = var.public_subnet1
}
output "nat_gateway" {
  value = aws_nat_gateway.public_nat.id
}