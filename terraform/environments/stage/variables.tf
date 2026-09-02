# Variables for the VPC
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

# Variables for application infrastructure
variable "dev_infra_bucket" {
  type = string
}

variable "dev_infra_key" {
  type = string
}

variable "lb_instance_type" {
  type = string
}

variable "lb_name" {
  type = string
}

variable "web_instances_count" {
  type = string
}

variable "web_instance_type" {
  type = string
}

variable "web_name" {
  type = string
}

variable "db_instance_type" {
  type = string
}

variable "db_name" {
  type = string
}

variable "lb_security_group_name" {
  type = string
}

variable "web_security_group_name" {
  type = string
}

variable "db_security_group_name" {
  type = string
}

# VPC Peering
variable "vpc_peering_name" {
  type = string
}

# S3
variable "bucket_name" {
  type = string
}

# Application roles
variable "role_name" {
  type = string
}

variable "role_profile_name" {
  type = string
}

variable "role_policy_name" {
  type = string
}

#Jenkins secrets
variable "database_private_ip_secret_name" {
    type = string
}

variable "web_server_1_private_ip_secret_name" {
    type = string
}

variable "web_server_2_private_ip_secret_name" {
    type = string
}
