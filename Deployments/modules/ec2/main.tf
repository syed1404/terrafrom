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
output "web1" {
  value = aws_instance.web_1.id
}

resource "aws_instance" "web_2" {
  ami           = var.ami_id  # Change this to a suitable Amazon Linux 2 AMI in your region
  instance_type = var.instance_type
  subnet_id     = var.public_subnet1
  vpc_security_group_ids = [var.instance_sg1]
  associate_public_ip_address = var.public_ip
}
output "ec2_web2" {
  value = aws_instance.web_2.id
}
output "ec2_web2_private_ip" {
  value = aws_instance.web_2.private_ip
}

output "ec2_web1_private_ip" {
  value = aws_instance.web_1.private_ip
}

