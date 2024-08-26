resource "aws_instance" "web_1" {
  ami           = var.ami_id  # Change this to a suitable Amazon Linux 2 AMI in your region
  instance_type = var.instance_type
  subnet_id     = var.private_subnet1
  vpc_security_group_ids = [var.instance_sg]
  associate_public_ip_address = var.public_ip
  user_data = var.user_data 
  tags = {
    Name = var.ec2_name
  }
}
output "ec2_web1" {
  value = aws_instance.web_1.id
}

