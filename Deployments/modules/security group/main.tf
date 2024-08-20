# Instance Security Group creation
resource "aws_security_group" "instance_sg" {
  vpc_id = var.vpc_id
 
  # Allow inbound traffic
  dynamic "ingress" {
    for_each = var.ingress_rule1
    content {
    from_port   = ingress.value.from_port
    to_port     = ingress.value.to_port
    protocol    = ingress.value.protocol
    cidr_blocks = ingress.value.cidr_block
    }
   
  }
  # Allow all outbound traffic (default behavior)
  dynamic "egress" {
    for_each = var.egress_rule1
    content {
    from_port   = egress.value.from_port
    to_port     = egress.value.to_port
    protocol    = egress.value.protocol
    cidr_blocks = egress.value.cidr_block
    }
  }
  tags = {
    Name = var.sg_name1
  }
}
output "instance_sg" {
  value = aws_security_group.instance_sg.id
}
 
# lb Security Group creation
resource "aws_security_group" "alb_sg" {
  vpc_id = var.vpc_id
 
  # Allow inbound traffic
  dynamic "ingress" {
    for_each = var.ingress_rule
    content {
    from_port   = ingress.value.from_port
    to_port     = ingress.value.to_port
    protocol    = ingress.value.protocol
    cidr_blocks = ingress.value.cidr_block
    }
}
  # Allow all outbound traffic (default behavior)
  dynamic "egress" {
    for_each = var.egress_rule
    content {
    from_port   = egress.value.from_port
    to_port     = egress.value.to_port
    protocol    = egress.value.protocol
    cidr_blocks = egress.value.cidr_block
    }
  }
  tags = {
    Name = var.sg_name
  }
}
output "lb_sg" {
  value = aws_security_group.alb_sg.id
}
resource "aws_security_group_rule" "lb_to_ec2" {
 type = var.rule_type
 from_port = var.allow_lb_to_ec2.from_port
 to_port = var.allow_lb_to_ec2.to_port
 protocol = var.allow_lb_to_ec2.protocol
 security_group_id = aws_security_group.instance_sg.id
 source_security_group_id = aws_security_group.alb_sg.id
}