module "security" {
  source = "./modules/security"
  vpc_id = module.network.app_vpc_id
}

module "network" {
  source                  = "./modules/network"
  vpc_cidr                = var.vpc_cidr
  private_app_subnet_cidr = var.private_app_subnet_cidr
  public_app_subnets_cidr = var.public_app_subnets_cidr
  private_db_subnet_cidr  = var.private_db_subnet_cidr
  availability_zones      = var.availability_zones
  # ssm_security_group          = module.security.app_ssm_endpoints_sg
}

module "jenkins" {
  source = "./modules/compute/jenkins"

  subnet_id            = module.network.app_private_subnet[0]
  ami_id               = "ami-0b4c0d3804e6d8485"
  instance_type        = "t3.medium"
  security_group_id    = module.security.app_jenkins_sg
  iam_instance_profile = module.security.app_jenkins_instance_profile
  key_name             = "app-jenkins-key"
}

module "alb" {
  source      = "./modules/compute/alb"
  subnet_id  =  module.network.app_public_subnet
  vpc_id      = module.network.app_vpc_id
  instance_id = module.jenkins.jenkins_instance_id
  alb_sg_id   = module.security.app_alb_sg
}

# module "compute"{
#   source = "./modules/compute"
# }
#
# module "loadbalancer"{
#   source = "./modules/loadbalancer"
# }
#
# module "rds"{
#   source = "./modules/rds"
# }
#
# module "regional_service" {
#   source = "./modules/regional-service"
# }