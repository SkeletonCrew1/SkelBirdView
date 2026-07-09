variable "region" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "private_subnet_cidr" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "internet_gateway_name" {
  type = string
}

variable "public_network_name" {
  type = string
}

variable "private_network_name" {
  type = string
}

variable "nat_eip_name" {
  type = string
}

variable "nat_gateway_name" {
  type = string
}

variable "public_route_table_name" {
  type = string
}

variable "private_route_table_name" {
  type = string
}

variable "ssm_sg_name" {
  type = string
}