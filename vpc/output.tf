output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main_vpc.id
}


output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = aws_vpc.main_vpc.arn
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main_vpc.cidr_block
}

output "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = aws_vpc.main_vpc.default_security_group_id
}

output "default_route_table_id" {
  description = "The ID of the default route table"
  value       = aws_vpc.main_vpc.default_route_table_id
}

output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.private_rt.id
}

output "public_web_subnet" {
  description = "ID of public web subnet"
  value       = aws_subnet.public_web_subnet[*].id
}

output "private_app_subnet" {
  description = "ID of private app subnet"
  value       = aws_subnet.private_app_subnet[*].id
}


output "private_db_subnet" {
  description = " ID of private db subnet"
  value       = aws_subnet.private_db_subnet[*].id
}


output "public_web_subnet_arns" {
  description = "ARN of public subnets"
  value       = aws_subnet.public_web_subnet[*].arn
}

output "private_app_subnet_arns" {
  description = "ARN of private app subnets"
  value       = aws_subnet.private_app_subnet[*].arn
}
output "private_db_subnet_arns" {
  description = "ARN of private db subnets"
  value       = aws_subnet.private_db_subnet[*].arn
}


output "igw-id" {
  description = "ID of igw "
  value       = aws_internet_gateway.igw.id
}
output "igw-arn" {
  description = "ARN of igw "
  value       = aws_internet_gateway.igw.arn
}


output "nat-gw-id" {
  description = "ID of Nat gateway"
  value       = aws_nat_gateway.nat_gw[*].id
}

output "nat-gw-arn" {
  description = "Public IP of Nat gateway"
  value       = aws_nat_gateway.nat_gw[*].public_ip
}

output "e-ip-public-addr" {
  description = "Elastic ip address attached to nat-gw"
  value       = aws_eip.e-ip[*].address
}
