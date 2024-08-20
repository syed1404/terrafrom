# Route Table creation
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
 
  route {
    cidr_block = var.cidr_block_rt
    gateway_id = var.ig_gateway
  }
 
  tags = {
    Name = var.rt_pub_name
  }
}
resource "aws_route_table" "private" {
 vpc_id = var.vpc_id
 route {
    cidr_block = var.cidr_block_rt
    gateway_id = var.nat_gateway
 }
 tags = {
   Name = var.rt_pvt_name
 }
}
# Route Table Association
resource "aws_route_table_association" "assoc_subnet_1" {
  subnet_id      = var.public_subnet1
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "assoc_subnet_2" {
  subnet_id = var.public_subnet2
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "assoc_subnet_3" {
  subnet_id = var.private_subnet1
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "assoc_subnet_4" {
  subnet_id = var.private_subnet2
  route_table_id = aws_route_table.private.id
}

 
