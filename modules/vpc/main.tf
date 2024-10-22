# VPC
resource "aws_vpc" "bqcore_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.bqcore_vpc.id
}

# Public Subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.bqcore_vpc.id
  cidr_block        = var.public_subnet_1_cidr
  availability_zone = "us-east-1a"  
  #availability_zone = var.public_az_1
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.bqcore_vpc.id
  cidr_block        = var.public_subnet_2_cidr
  availability_zone = "us-east-1b"  
  #availability_zone = var.public_az_2
  map_public_ip_on_launch = true
}

# Private Subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.bqcore_vpc.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = "us-east-1c"  
  #availability_zone = var.private_az_1
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.bqcore_vpc.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = "us-east-1a"  
  #availability_zone = var.private_az_2
}

# NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id
  depends_on    = [aws_internet_gateway.gw]
}

# Public Route Table and Associations
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.bqcore_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public_rta1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_rta2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

# Private Route Table and Associations
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.bqcore_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

resource "aws_route_table_association" "private_rta1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_rta2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}
