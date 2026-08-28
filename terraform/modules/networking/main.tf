# VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.internet_gateway_name
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id

  cidr_block = var.public_subnet_cidr

  availability_zone = data.aws_availability_zones.available.names[0]

  map_public_ip_on_launch = true

  tags = {
    Name = var.public_network_name
  }
}

# Private Subnet
resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id

  cidr_block = var.private_subnet_cidr

  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = var.private_network_name
  }
}

# Elastic IP
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = var.nat_eip_name
  }
}

# NAT Gateway
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id

  subnet_id = aws_subnet.public.id

  depends_on = [
    aws_internet_gateway.main
  ]

  tags = {
    Name = var.nat_gateway_name
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.public_route_table_name
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public.id

  route_table_id = aws_route_table.public.id
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.private_route_table_name
  }
}

resource "aws_route" "private_subnet_nat" {
  route_table_id = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.main.id
}

resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.private.id

  route_table_id = aws_route_table.private.id
}

# SSM Endpoints
resource "aws_vpc_endpoint" "ssm" {
  vpc_id = aws_vpc.main.id
  service_name = "com.amazonaws.eu-north-1.ssm"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.ssm-sg.id
  ]

  subnet_ids = [
    aws_subnet.private.id
  ]

  private_dns_enabled = true

  tags = {
    Name = "ssm"
  }
}

resource "aws_vpc_endpoint" "ssm-messages" {
  vpc_id = aws_vpc.main.id
  service_name = "com.amazonaws.eu-north-1.ssmmessages"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.ssm-sg.id
  ]

  subnet_ids = [
    aws_subnet.private.id
  ]

  private_dns_enabled = true

  tags = {
    Name = "ssm-messages"
  }
}

resource "aws_vpc_endpoint" "ssm-ec2" {
  vpc_id = aws_vpc.main.id
  service_name = "com.amazonaws.eu-north-1.ec2messages"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.ssm-sg.id
  ]

  subnet_ids = [
    aws_subnet.private.id
  ]

  private_dns_enabled = true

  tags = {
    Name = "ssm-ec2-messages"
  }
}

resource "aws_security_group" "ssm-sg" {
  name   = var.ssm_sg_name
  vpc_id = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "ssm-http" {
  security_group_id = aws_security_group.ssm-sg.id

  cidr_ipv4 = "0.0.0.0/0"
  from_port = 443
  to_port   = 443

  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "ssm-default" {
  security_group_id = aws_security_group.ssm-sg.id

  referenced_security_group_id = aws_security_group.ssm-sg.id

  ip_protocol = "-1"
}

resource "aws_vpc_security_group_egress_rule" "ssm-egress" {
  security_group_id = aws_security_group.ssm-sg.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"
}