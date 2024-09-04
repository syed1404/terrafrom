# Instance Security Group creation
resource "aws_security_group" "instance_sg" {
  vpc_id = var.vpc_id
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
output "alb_sg" {
  value = aws_security_group.alb_sg.id
}
resource "aws_security_group_rule" "lb_to_ec2" {
 type = var.rule_type
 from_port = var.allow_lb_to_ec2.from_port
 to_port = var.allow_lb_to_ec2.to_port
 protocol = var.allow_lb_to_ec2.protocol
 security_group_id = aws_security_group.instance_sg.id
 source_security_group_id = aws_security_group.ailb_sg.id
}

resource "aws_security_group" "instance_sg1" {
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
    Name = var.sg_name2
  }
}
resource "aws_security_group_rule" "ec2_to_ec2" {
 type = var.rule_type
 from_port = var.allow_ec2_to_ec2.from_port
 to_port = var.allow_ec2_to_ec2.to_port
 protocol = var.allow_ec2_to_ec2.protocol
 security_group_id = aws_security_group.instance_sg.id
 cidr_blocks = ["${var.ec2_web2_private_ip}/32"]
}
output "instance_sg1" {
  value = aws_security_group.instance_sg1.id
}

# ilb Security Group creation
resource "aws_security_group" "ailb_sg" {
  vpc_id = var.vpc_id
 
  tags = {
    Name = var.sg_name3
  }
}
output "ailb_sg" {
  value = aws_security_group.ailb_sg.id
}

resource "aws_security_group_rule" "lb_to_ilb" {
 type = var.rule_type
 from_port = var.allow_lb_to_ec2.from_port
 to_port = var.allow_lb_to_ec2.to_port
 protocol = var.allow_lb_to_ec2.protocol
 security_group_id = aws_security_group.ailb_sg.id
 source_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group" "rds_sg" {
  vpc_id = var.vpc_id

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
    Name = var.sg_name2
  }

}

resource "aws_security_group_rule" "prvserver_to_db" {
  type              = var.rule_type
  from_port         = var.prvserver_to_db.from_port
  to_port           = var.prvserver_to_db.to_port
  protocol          = var.prvserver_to_db.protocol
  cidr_blocks       = ["${var.ec2_web1_private_ip}/32"]
  security_group_id =aws_security_group.rds_sg.id
}

output "rds_sg" {
  value = aws_security_group.rds_sg.id
}
