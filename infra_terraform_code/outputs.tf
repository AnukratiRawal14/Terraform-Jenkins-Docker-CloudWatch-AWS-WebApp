output "vpc_id" {
  value = module.network.app_vpc_id
}
output "app_public_subnet" {
  value = module.network.app_public_subnet[*]
}

output "app_private_subnet" {
  value = module.network.app_private_subnet[*]
}

output "db_private_subnet" {
  value = module.network.db_private_subnet[*]
}

output "app_alb_sg" {
  value = module.security.app_alb_sg
}

output "app_backend_sg" {
  value = module.security.app_backend_sg
}

output "app_jenkins_sg" {
  value = module.security.app_jenkins_sg
}

output "app_rds_sg" {
  value = module.security.app_rds_sg
}

output "app_jenkins_instance_profile" {
  value = module.security.app_jenkins_instance_profile
}

output "app_backend_instance_profile" {
  value = module.security.app_backend_instance_profile
}

output "app_jenkins_role" {
  value = module.security.app_jenkins_role
}

output "app_backend_role" {
  value = module.security.app_backend_role
}

output "jenkins_instance_id" {
  value = module.jenkins.jenkins_instance_id
}

output "jenkins_private_ip" {
  value = module.jenkins.jenkins_private_ip
}