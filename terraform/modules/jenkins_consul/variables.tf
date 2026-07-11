variable "region" {
  type = string
}

variable "jenkins_ami" {
  type = string
}

variable "jenkins_instance_type" {
  type = string
}

variable "jenkins_subnet_id" {
  type = string
}

variable "jenkins_disk_size" {
  type = number
}

variable "jenkins_name" {
  type = string
}

variable "consul_ami" {
  type = string
}

variable "consul_instance_type" {
  type = string
}

variable "consul_subnet_id" {
  type = string
}

variable "consul_name" {
  type = string
}

variable "dev_infra_vpc_id" {
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