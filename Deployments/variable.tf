#variable for VPC
variable "vpc_cidr" {
    description = "The CIDR value of VPC"
    type = string
    default = "10.0.0.0/16"
  }
variable "vpc_name" {
    description = "The name of VPC"
    type = string
    default = "test"
}
# variable for subnet
variable "vpc_public_subnet" {
    description = "The public subnet of VPC"
    type = string
    default = "10.0.0.0/24"
}
variable "vpc_public_subnet_name" {
    description = "The name of public subnet of VPC"
    type = string
    default = "public test"
  
}
variable "vpc_public_subnet1" {
    description = "The public subnet of VPC"
    type = string
    default = "10.0.2.0/24"
}
variable "vpc_public_subnet_name1" {
    description = "The name of public subnet of VPC"
    type = string
    default = "public test1"
  
}

variable "vpc_private_subnet" {
    description = "The private subnet of VPC"
    type = string
    default = "10.0.1.0/24"
}
variable "vpc_private_subnet_name" {
    description = "The name of private subnet of VPC"
    type = string
    default = "private test"
  
}

#variable for security group
variable "sg_name" {
  description = "Name of security group"
  type = string
  default = "lb-security-group"
}
variable "ingress_rule" {
    description = "List of inbound rule"
    type = list(object({
      from_port = number
      to_port = number
      protocol = string
      cidr_block = list(string)
    }))
    default = [ {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_block = [ "0.0.0.0/0" ]
    }]
}
variable "egress_rule" {
    description = "List of outbound rule"
    type = list(object({
      from_port = number
      to_port = number
      protocol = string
      cidr_block = list(string)
    }))
    default = [ {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_block = [ "0.0.0.0/0" ]
    } ]
  
}

variable "sg_name1" {
  description = "Name of security group"
  type = string
  default = "instance-security-group"
}
variable "ingress_rule1" {
    description = "List of inbound rule"
    type = list(object({
      from_port = number
      to_port = number
      protocol = string
      cidr_block = list(string)
    }))
    default = [
    {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_block = [ "0.0.0.0/0" ]  
    } ]
}
variable "egress_rule1" {
    description = "List of outbound rule"
    type = list(object({
      from_port = number
      to_port = number
      protocol = string
      cidr_block = list(string)
    }))
    default = [ {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_block = [ "0.0.0.0/0" ]
    } ]
  
}
variable "allow_lb_to_ec2" {
    description = "Allow traffic form ALB to EC2"
    type = object({
      from_port = number
      to_port = number
      protocol = string
    })
    default = {
      from_port = 80
      to_port = 80
      protocol = "tcp"
    }
}
# variable for EC2
variable "ec2_name" {
    description = "name of ec2 instance"
    type = string
    default = "app-ec2-001" 
}

variable "rule_type" {
  description = "whether it is inbound or outbound"
  type = string
  default = "ingress"
}

variable "instance_type" {
  description = "The type of ec2"
  type = string
  default = "t2.micro"
}
variable "ami_id" {
   description = "The flavour of os"
   type = string
   default = "ami-0427090fd1714168b"
}
variable "public_ip" {
    description = "Does the EC2 require a public IP"
    type = bool
    default = "false"
}
variable "user_data" {
  description = "The script to run while launching the ec2"
  type = string
  default =  <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd
                systemctl start httpd
                systemctl enable httpd

                # Creating the HTML file with frontend and backend logic
                cat <<EOT > /var/www/html/index.html
                <!DOCTYPE html>
                <html lang="en">
                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Login Form</title>
                    <style>
                        body {
                            font-family: Arial, sans-serif;
                            background-color: #f4f4f4;
                            margin: 0;
                            padding: 20px;
                        }
                        .container {
                            width: 300px;
                            margin: 0 auto;
                            padding: 20px;
                            background-color: #fff;
                            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                        }
                        h1 {
                            text-align: center;
                            color: #333;
                        }
                        label {
                            font-weight: bold;
                            display: block;
                            margin-top: 10px;
                        }
                        input[type="text"],
                        input[type="password"] {
                            width: 100%;
                            padding: 10px;
                            margin: 10px 0;
                            border: 1px solid #ccc;
                            border-radius: 5px;
                        }
                        input[type="submit"] {
                            width: 100%;
                            padding: 10px;
                            background-color: #007bff;
                            color: white;
                            border: none;
                            border-radius: 5px;
                            cursor: pointer;
                        }
                        input[type="submit"]:hover {
                            background-color: #0056b3;
                        }
                        .error {
                            color: red;
                            margin-top: 10px;
                        }
                    </style>
                </head>
                <body>
                    <div class="container">
                        <h1>Login</h1>
                        <form id="loginForm">
                            <label for="username">Username:</label>
                            <input type="text" id="username" name="username" required>
                            <label for="password">Password:</label>
                            <input type="password" id="password" name="password" required>
                            <input type="submit" value="Login">
                            <div id="error-message" class="error"></div>
                        </form>
                    </div>

                    <script>
                        // JavaScript for handling form validation and login logic
                        document.getElementById('loginForm').addEventListener('submit', function(event) {
                            event.preventDefault();

                            var username = document.getElementById('username').value;
                            var password = document.getElementById('password').value;
                            var errorMessage = document.getElementById('error-message');

                            // Simple validation logic
                            if (username === 'admin' && password === 'password') {
                                errorMessage.textContent = '';
                                alert('Login Successful');
                            } else {
                                errorMessage.textContent = 'Invalid username or password';
                            }
                        });
                    </script>
                </body>
                </html>
                EOT
              EOF
}
#variable for ALB
variable "alb_name" {
  description = "Name of ALB"
  type = string
  default = "test-alb"
}
variable "alb_scheme" {
    description = "Scheme of ALB"
    type = bool
    default = false 
}
variable "alb_type" {
  description = "Type of LB"
  type = string
  default = "application"
}
#variable for listener & Target group
variable "alb_listener80" {
  description = "Ports to listen"
  type = object({
    port = number
    protocol = string
  })
  default = {
    port = 80
    protocol = "HTTP"
  }
}
variable "action_listener" {
  description = "Listener action"
  type = string
  default = "forward"
}
variable "alb_health" {
  description = "health check of ALB"
  type = object({
    path                 = string
    interval             = number
    timeout              = number
    healthy_threshold    = number
    unhealthy_threshold  = number
  })
  default = {
    path                 = "/"
    interval             = 30
    timeout              = 5
    healthy_threshold    = 3
    unhealthy_threshold  = 3
  }
}
variable "aws_lb_target_group" {
  description = "Target group for ALB"
  type = object({
    name        = string
    port        = number
    protocol    = string
    target_type = string
  })
  default = {
    name = "test-target-group"
    port = 80
    protocol = "HTTP"
    target_type = "instance"
  }
}

#################################


