output "jenkins_instance_id" {
  value = aws_instance.app_jenkins.id
}

output "jenkins_private_ip" {
  value = aws_instance.app_jenkins.private_ip
}
