module "network" {
  source                  = "./modules/network"
  vpc_cidr                = var.vpc_cidr
  private_app_subnet_cidr = var.private_app_subnet_cidr
  public_app_subnets_cidr = var.public_app_subnets_cidr
  private_db_subnet_cidr  = var.private_db_subnet_cidr
  availability_zones      = var.availability_zones
}

# module "security" {
#   source = "./modules/security"
# }

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