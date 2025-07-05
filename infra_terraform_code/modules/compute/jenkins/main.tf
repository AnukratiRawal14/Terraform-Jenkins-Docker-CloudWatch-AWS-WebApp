resource "aws_instance" "app_jenkins" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  iam_instance_profile   = var.iam_instance_profile
  key_name               = var.key_name # (optional)

  associate_public_ip_address = false  # Private subnet, no public IP

  tags = {
    Name = "App-Jenkins-Server"
  }

  user_data = file("${path.module}/app-jenkins-userdata.sh")
}
