# VPC creation
resource "aws_vpc" "test" {
  cidr_block = var.vpc_cidr
    tags = {
        name = var.vpc_name
    }
  }


# Public subnet 1 creation
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.test.id
  cidr_block              = var.vpc_public_subnet
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = var.vpc_public_subnet_name
  }
}

# Public subnet 2 creation
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.test.id
  cidr_block              = var.vpc_public_subnet1
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = var.vpc_public_subnet_name1
  }
}

# Private subnet 1 creation
resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.test.id
  cidr_block              = var.vpc_private_subnet
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = var.vpc_private_subnet_name
  }
}

# Internet Gateway creation
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.test.id
  tags = {
    Name = "ig-gateway"
  }
}

#NAT Gateway Creation
resource "aws_eip" "nat_ip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "public_nat" {
allocation_id = aws_eip.nat_ip.id
subnet_id = aws_subnet.public_subnet_1.id
}

# Route Table creation
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Route Table creation
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.public_nat.id
  }

  tags = {
    Name = "private-route-table"
  }
}

# Route Table Association for subnet 1
resource "aws_route_table_association" "assoc_subnet_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public.id
}

# Route Table Association for subnet 2
resource "aws_route_table_association" "assoc_subnet_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public.id
}

# Route Table Association for subnet 3
resource "aws_route_table_association" "assoc_subnet_3" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private.id
}

# Instance Security Group creation
resource "aws_security_group" "instance_sg" {
  vpc_id = aws_vpc.test.id

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

# lb Security Group creation
resource "aws_security_group" "alb_sg" {
  vpc_id = aws_vpc.test.id

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
resource "aws_security_group_rule" "lb_to_ec2" {
 type = var.rule_type
 from_port = var.allow_lb_to_ec2.from_port
 to_port = var.allow_lb_to_ec2.to_port
 protocol = var.allow_lb_to_ec2.protocol
 security_group_id = aws_security_group.instance_sg.id
 source_security_group_id = aws_security_group.alb_sg.id 
}
resource "aws_instance" "web_1" {
  ami           = var.ami_id  # Change this to a suitable Amazon Linux 2 AMI in your region
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private_subnet_1.id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  associate_public_ip_address = var.public_ip


user_data = var.user_data

  tags = {
    Name = var.ec2_name
  }
}

resource "aws_lb" "test" {
  name               = "test-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  
  subnets            = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]

  enable_deletion_protection = false
  enable_cross_zone_load_balancing = true
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.test.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn   = aws_lb_target_group.test.arn
    }
  }

resource "aws_lb_target_group" "test" {
  name        = "example-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.test.id
  target_type = "instance"  # or "ip" depending on your setup

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold    = 3
    unhealthy_threshold  = 3
  }

  tags = {
    Name = "example-target-group"
  }
}
resource "aws_lb_target_group_attachment" "example" {
  count              = length(aws_instance.web_1.*.id)
  target_group_arn   = aws_lb_target_group.test.arn
  target_id          = aws_instance.web_1.id
  port               = 80  # Port that the target group listens on
}



