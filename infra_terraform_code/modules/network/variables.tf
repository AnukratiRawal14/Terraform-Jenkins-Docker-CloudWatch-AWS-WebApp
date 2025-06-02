variable "vpc_cidr" { type = string }
variable "public_app_subnets_cidr" { type = list(string) }
variable "private_app_subnet_cidr" { type = list(string) }
variable "private_db_subnet_cidr" { type = list(string) }
variable "availability_zones" { type = list(string) }
