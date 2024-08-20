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
variable "private_subnet1" {
  type = string
}
variable "ec2_name" {
    description = "name of ec2 instance"
    type = string
    default = "app-ec2-001" 
}
variable "instance_sg" {
  type = string
}
