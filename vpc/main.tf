##########################################################
#VPC
##########################################################

resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc-cidr

  tags = {
    Name        = var.vpc-name
    Environment = var.environment
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name        = "${var.vpc-name}-default-sg"
    Environment = var.environment
  }


}

##########################################################
#Internet Gateway
##########################################################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    "Name"      = "${var.vpc-name}-igw"
    Environment = var.environment
  }
}

##########################################################
#Default Route Table
##########################################################
resource "aws_default_route_table" "public_rt" {
  default_route_table_id = aws_vpc.main_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${var.vpc-name}-default-rt"
    Environment = var.environment
  }
}

# resource "aws_main_route_table_association" "assoc1" {
#   vpc_id         = aws_vpc.main_vpc.id
#   route_table_id = aws_default_route_table.public_rt.id
# }

##########################################################
#Private Route Table
##########################################################
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name        = "${var.vpc-name}-private-rt"
    Environment = var.environment
  }
}


resource "aws_route" "private_rt_route" {
  count                  = var.enable_nat_gateway ? 1 : 0
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat_gw[0].id
}

##########################################################
#Public Web Subnet
##########################################################

resource "aws_subnet" "public_web_subnet" {
  count             = length(var.public_web_subnet-cidr)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.public_web_subnet-cidr[count.index]
  availability_zone = var.availability_zone[count.index]


  tags = {
    Name        = "${var.vpc-name}-subnet-public-web-${var.availability_zone[count.index]}"
    Environment = var.environment
  }
}

##########################################################
#Private App Subnet
##########################################################

resource "aws_subnet" "private_app_subnet" {
  count             = length(var.private_app_subnet-cidr)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_app_subnet-cidr[count.index]
  availability_zone = var.availability_zone[count.index]



  tags = {
    Name        = "${var.vpc-name}-subnet-private-app-${var.availability_zone[count.index]}"
    Environment = var.environment
  }
}

##########################################################
#Private DB Subnet
##########################################################

resource "aws_subnet" "private_db_subnet" {
  count             = length(var.private_db_subnet-cidr)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_db_subnet-cidr[count.index]
  availability_zone = var.availability_zone[count.index]


  tags = {
    Name        = "${var.vpc-name}-subnet-private-db-${var.availability_zone[count.index]}"
    Environment = var.environment
  }
}

##########################################################
#Default NACL
##########################################################

resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.main_vpc.default_network_acl_id

  tags = {
    Name        = "${var.vpc-name}-nacl"
    Environment = var.environment
  }

}

##########################################################
# NAT Gateway
##########################################################

resource "aws_eip" "e-ip" {
  count = var.enable_nat_gateway ? 1 : 0
  vpc   = true
  tags = {
    "Name"      = "${var.vpc-name}-nat_gw-e-ip"
    Environment = var.environment
  }
}

resource "aws_nat_gateway" "nat_gw" {
  count         = var.enable_nat_gateway ? 1 : 0
  allocation_id = var.enable_nat_gateway ? aws_eip.e-ip[count.index].id : null
  subnet_id     = aws_subnet.public_web_subnet[0].id
  tags = {
    Name        = "${var.vpc-name}-nat_gw"
    Environment = var.environment
  }


  depends_on = [aws_internet_gateway.igw]
}

##########################################################
#Route Table Association
##########################################################

resource "aws_route_table_association" "assoc2" {
  count          = length(var.private_app_subnet-cidr)
  subnet_id      = aws_subnet.private_app_subnet[count.index].id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "assoc3" {
  count          = length(var.private_db_subnet-cidr)
  subnet_id      = aws_subnet.private_db_subnet[count.index].id
  route_table_id = aws_route_table.private_rt.id
}

