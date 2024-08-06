provider "aws" {
  region = "us-east-1"  # Change this to your preferred region
}

# VPC creation
resource "aws_vpc" "test" {
  cidr_block = var.vpc_cidr
    tags = {
        name = var.vpc_name
    }
  }


# Public subnet 1 creation
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.vpc_public_subnet
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = var.vpc_public_subnet_name
  }
}

# Private subnet 1 creation
resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.vpc_private_subnet
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = var.vpc_private_subnet_name
  }
}

# Internet Gateway creation
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "ig-gateway"
  }
}

# Route Table creation
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public-route-table"
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

# Security Group creation
resource "aws_security_group" "instance_sg" {
  vpc_id = aws_vpc.main.id

  # Allow inbound HTTP traffic
  ingress {
    from_port   = ingress.value.from_port
    to_port     = ingress.value.to_port
    protocol    = ingress.value.protocol
    cidr_blocks = ingress.value.cidr_block
  }
  # Allow all outbound traffic (default behavior)
  egress {
    from_port   = egress.value.from_port
    to_port     = egress.value.to_port
    protocol    = egress.value.protocol
    cidr_blocks = egress.value.cidr_block
  }

  tags = {
    Name = var.sg_name
  }
}

resource "aws_instance" "web_2" {
  ami           = "ami-0427090fd1714168b"  # Change this to a suitable Amazon Linux 2 AMI in your region
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  associate_public_ip_address = true


user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd
                systemctl start httpd
                systemctl enable httpd
                echo "<html><h1>Hello from EC2!</h1></html>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "web-instance"
  }
}
resource "aws_lb" "example" {
  name               = "example-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.instance_sg.id]
  
  subnets            = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]

  enable_deletion_protection = false
  enable_cross_zone_load_balancing = true


   }


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn   = aws_lb_target_group.example.arn
    }
  }

resource "aws_lb_target_group" "example" {
  name        = "example-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
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
  count              = length(aws_instance.web_2.*.id)
  target_group_arn   = aws_lb_target_group.example.arn
  target_id          = aws_instance.web_2.id
  port               = 80  # Port that the target group listens on
}


