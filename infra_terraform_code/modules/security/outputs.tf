output "app_alb_sg" {
  value = aws_security_group.app_alb_sg.id
}

output "app_backend_sg" {
  value = aws_security_group.app_backend_sg.id
}

output "app_jenkins_sg" {
  value = aws_security_group.app_jenkins_sg.id
}

output "app_rds_sg" {
  value = aws_security_group.app_rds_sg.id
}

# output "app_ssm_endpoints_sg" {
#   value = aws_security_group.app_ssm_endpoints_sg.id
# }

output "app_jenkins_instance_profile" {
  value = aws_iam_instance_profile.app_jenkins_instance_profile.name
}

output "app_backend_instance_profile" {
  value = aws_iam_instance_profile.app_backend_instance_profile.name
}

output "app_jenkins_role" {
  value = aws_iam_role.app_jenkins_role.arn
}

output "app_backend_role" {
  value = aws_iam_role.app_backend_role.arn
}