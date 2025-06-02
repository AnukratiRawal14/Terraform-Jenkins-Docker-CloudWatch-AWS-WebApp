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
