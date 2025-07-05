resource "aws_security_group" "app_alb_sg" {
  name        = "app-alb-sg"
  description = "Allow HTTPs traffic to ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app-alb-jenkins-target-group"
  }
}

# Backend EC2 Security Group
resource "aws_security_group" "app_backend_sg" {
  name        = "app-backend-ec2-sg"
  description = "Allow ALB traffic to backend EC2"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow traffic from ALB"
    from_port       = 5000 # Change if your app listens on other port
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.app_alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Jenkins EC2 Security Group
resource "aws_security_group" "app_jenkins_sg" {
  name        = "app-jenkins-sg"
  description = "Allow SSM Session Manager"
  vpc_id      = var.vpc_id


  ingress {
    description = "Allow HTTP for Jenkins UI"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH (optional)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["49.43.3.147/32"]  # Replace with your IP (for SSH if needed)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound (required for yum, Jenkins repo, etc)
  }
}

# RDS Security Group
resource "aws_security_group" "app_rds_sg" {
  name        = "app-rds-sg"
  description = "Allow DB access from backend EC2"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow backend EC2 to access RDS"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_backend_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# needed when we need private tunnel between local system and ec2
# resource "aws_security_group" "app_ssm_endpoints_sg" {
#   name        = "app-ssm-endpoints-sg"
#   description = "Allow HTTPS from EC2 instances for SSM"
#   vpc_id      = var.vpc_id
#
#   ingress {
#     from_port       = 443
#     to_port         = 443
#     protocol        = "tcp"
#     description     = "Allow HTTPS from EC2 instance SG"
#     security_groups = [aws_security_group.app_jenkins_sg.id]
#   }
#
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   tags = {
#     Name = "app-ssm-endpoints-sg"
#   }
# }
