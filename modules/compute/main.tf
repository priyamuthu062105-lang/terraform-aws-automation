# IAM role that can be assumed by EC2
resource "aws_iam_role" "ec2_role" {
  name = "${var.environment}-project03-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "${var.environment}-project03-ec2-role"
  }
}

# Instance profile used to attach the IAM role to EC2
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.environment}-project03-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

# EC2 web server
resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  user_data = <<-EOF_USER_DATA
              #!/bin/bash
              set -e

              apt-get update -y
              apt-get install -y nginx

              cat > /var/www/html/index.html <<'HTML'
              <!DOCTYPE html>
              <html>
              <head>
                <title>Project-03</title>
              </head>
              <body>
                <h1>AWS Infrastructure Automation Using Terraform</h1>
                <h2>Project-03</h2>
                <p>This EC2 web server was provisioned automatically using Terraform.</p>
              </body>
              </html>
              HTML

              systemctl enable nginx
              systemctl restart nginx
              EOF_USER_DATA

  tags = {
    Name = "${var.environment}-project03-web-server"
  }
}

# Elastic IP for the web server
resource "aws_eip" "web" {
  domain = "vpc"

  tags = {
    Name = "${var.environment}-project03-eip"
  }
}

# Associate the Elastic IP with EC2
resource "aws_eip_association" "web" {
  instance_id   = aws_instance.web.id
  allocation_id = aws_eip.web.id
}
