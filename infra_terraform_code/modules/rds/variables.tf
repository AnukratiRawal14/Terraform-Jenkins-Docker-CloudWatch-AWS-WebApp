variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_engine" {
  type    = string
  default = "mysql"
}

variable "db_name" {
  type    = string
  default = "myappdb"
}

variable "db_username" {
  type    = string
}

variable "db_password" {
  type    = string
  sensitive = true
}

variable "db_subnets" {
  type = list(string)
}
