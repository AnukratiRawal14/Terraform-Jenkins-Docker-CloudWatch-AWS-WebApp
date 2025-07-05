variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

# Environment name (prod, dev, stage)
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

# Project name
variable "project_name" {
  description = "Name of the project/application"
  type        = string
  default     = "webapp"
}

# VPC CIDR block
variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

# Public Subnets
variable "public_app_subnets_cidr" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# Private App Subnets
variable "private_app_subnet_cidr" {
  description = "List of private app subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

# Private DB Subnets
variable "private_db_subnet_cidr" {
  description = "List of private DB subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.5.0/24", "10.0.6.0/24"]
}

# AZs
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}