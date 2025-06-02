output "app_vpc_id" {
  value = aws_vpc.app_vpc.id
}
output "app_public_subnet" {
  value = aws_subnet.app_public_subnet_01[*].id
}

output "app_private_subnet" {
  value = aws_subnet.app_private_subnet[*].id
}

output "db_private_subnet" {
  value = aws_subnet.db_private_subnet[*].id
}