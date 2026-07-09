# 1. Create the VPC Peering Connection
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = var.main_vpc_id   # Main VPC
  peer_vpc_id   = var.application_vpc      # Application VPC
  auto_accept   = true

  tags = {
    Name = var.vpc_peering_name # Name of VPC peeriing
  }
}

# 2. Add route from VPC A to VPC B
resource "aws_route" "route_a_to_b" {
  route_table_id            = var.main_vpc_rt # RT for main VPC
  destination_cidr_block    = var.application_vpc_cidr # Route for application VPC CIDR
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

# 3. Add route from VPC B to VPC A
resource "aws_route" "route_b_to_a" {
  route_table_id            = var.application_vpc_rt # RT for application VPC
  destination_cidr_block    = var.main_vpc_cidr # Route for main VPC CIDR
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}