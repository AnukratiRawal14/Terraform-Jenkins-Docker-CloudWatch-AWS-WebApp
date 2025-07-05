terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}

resource "aws_vpc" "app_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "App VPC"
  }
}

resource "aws_subnet" "app_public_subnet_01" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.app_vpc.id
  cidr_block              = var.public_app_subnets_cidr[count.index]
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[count.index]
  tags = {
    Name = "AppPublicSubnet-${var.availability_zones[count.index]}"
  }
}


resource "aws_subnet" "app_private_subnet" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.private_app_subnet_cidr[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "AppPrivateSubnet-${var.availability_zones[count.index]}"
  }
}

resource "aws_subnet" "db_private_subnet" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.private_db_subnet_cidr[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "DBPrivateSubnet-${var.availability_zones[count.index]}"
  }
}

resource "aws_internet_gateway" "app_igw" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    Name = "APP-IGW"
  }
}

resource "aws_eip" "app_nat_eip" {
  count  = length(var.availability_zones)
  domain = "vpc"
}

resource "aws_nat_gateway" "app_nat_gateway" {
  count         = length(var.availability_zones)
  subnet_id     = aws_subnet.app_public_subnet_01[count.index].id
  allocation_id = aws_eip.app_nat_eip[count.index].id
  tags = {
    Name = "APP-NAT-${var.availability_zones[count.index]}-GW"
  }
}

resource "aws_route_table" "public_app_route_table" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app_igw.id
  }

  tags = {
    Name = "APP-Public-${var.availability_zones[count.index]}-RT"
  }
}

resource "aws_route_table_association" "public_rt_assoc" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.app_public_subnet_01[count.index].id
  route_table_id = aws_route_table.public_app_route_table[count.index].id
}

resource "aws_route_table" "private_app_route_table" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.app_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.app_nat_gateway[count.index].id
  }
  tags = {
    Name = "APP-Private-${var.availability_zones[count.index]}-RT"
  }
}

resource "aws_route_table_association" "private_rt_assoc" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.app_private_subnet[count.index].id
  route_table_id = aws_route_table.private_app_route_table[count.index].id
}

resource "aws_route_table" "private_db_route_table" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name = "DB-Private-${var.availability_zones[count.index]}-RT"
  }
}

resource "aws_route_table_association" "db_rt_assoc" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.db_private_subnet[count.index].id
  route_table_id = aws_route_table.private_db_route_table[count.index].id
}


# ssm enpoints - used when needed private tunnel
# resource "aws_vpc_endpoint" "ssm" {
#   vpc_id            = aws_vpc.app_vpc.id
#   service_name      = "com.amazonaws.${data.aws_region.current.name}.ssm"
#   vpc_endpoint_type = "Interface"
#   subnet_ids        = [for s in aws_subnet.app_private_subnet : s.id]
#   security_group_ids = [var.ssm_security_group]
#   private_dns_enabled = true
# }
#
# resource "aws_vpc_endpoint" "ssmmessages" {
#   vpc_id            = aws_vpc.app_vpc.id
#   service_name      = "com.amazonaws.${data.aws_region.current.name}.ssmmessages"
#   vpc_endpoint_type = "Interface"
#   subnet_ids        = [for s in aws_subnet.app_private_subnet : s.id]
#   security_group_ids = [var.ssm_security_group]
#   private_dns_enabled = true
# }
#
# resource "aws_vpc_endpoint" "ec2messages" {
#   vpc_id            = aws_vpc.app_vpc.id
#   service_name      = "com.amazonaws.${data.aws_region.current.name}.ec2messages"
#   vpc_endpoint_type = "Interface"
#   subnet_ids        = [for s in aws_subnet.app_private_subnet : s.id]
#   security_group_ids = [var.ssm_security_group]
#   private_dns_enabled = true
# }
