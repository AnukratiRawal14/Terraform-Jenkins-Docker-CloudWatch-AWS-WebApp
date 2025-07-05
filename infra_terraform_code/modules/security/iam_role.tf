# Jenkins EC2 IAM Role
resource "aws_iam_role" "app_jenkins_role" {
  name = "app-jenkins-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "app_jenkins_managed_policy" {
  role       = aws_iam_role.app_jenkins_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Attach SSM policy to Jenkins EC2 role
resource "aws_iam_role_policy_attachment" "app_jenkins_ssm_policy" {
  role       = aws_iam_role.app_jenkins_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Backend EC2 IAM Role
resource "aws_iam_role" "app_backend_role" {
  name = "app-backend-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "app_backend_managed_policy" {
  role       = aws_iam_role.app_backend_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Attach SSM policy to Jenkins EC2 role
resource "aws_iam_role_policy_attachment" "app_backend_ssm_policy" {
  role       = aws_iam_role.app_backend_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
# Instance profiles to attach to EC2s
resource "aws_iam_instance_profile" "app_jenkins_instance_profile" {
  name = "app-jenkins-instance-profile"
  role = aws_iam_role.app_jenkins_role.name
}

resource "aws_iam_instance_profile" "app_backend_instance_profile" {
  name = "app-backend-instance-profile"
  role = aws_iam_role.app_backend_role.name
}
