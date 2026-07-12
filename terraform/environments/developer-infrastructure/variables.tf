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

# Variables for developer infrastructure
variable "jenkins_instance_type" {
  type = string
}

variable "jenkins_disk_size" {
  type = number
}

variable "jenkins_name" {
  type = string
}

variable "consul_instance_type" {
  type = string
}

variable "consul_name" {
  type = string
}

variable "jenkins_role_name" {
  type = string
}

variable "jenkins_profile_name" {
  type = string
}

variable "jenkins_policy_name" {
  type = string
}

variable "consul_role_name" {
  type = string
}

variable "consul_profile_name" {
  type = string
}

variable "consul_policy_name" {
  type = string
}