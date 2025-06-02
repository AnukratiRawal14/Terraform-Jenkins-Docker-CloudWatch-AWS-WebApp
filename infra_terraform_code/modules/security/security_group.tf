# ALB Security Group
resource "aws_security_group" "app_alb_sg" {
  name        = "app-alb-sg"
  description = "Allow HTTPs traffic to ALB"
  vpc_id      = var.vpc_id

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
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
