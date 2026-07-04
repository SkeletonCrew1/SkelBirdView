variable "access_key" {
  type      = string
  sensitive = true
  default   = env("access_key")
}

variable "secret_key" {
  type      = string
  sensitive = true
  default   = env("secret_key")
}

variable "ssh_username" {
  type      = string
  sensitive = true
  default   = env("ssh_username")
}

variable "region" {
  type      = string
  sensitive = true
  default   = env("region")
}

variable "vpc_id" {
  type      = string
  sensitive = true
  default   = env("vpc_id")
}

variable "subnet_id" {
  type      = string
  sensitive = true
  default   = env("subnet_id")
}

variable "security_group_id" {
  type      = string
  sensitive = true
  default   = env("security_group_id")
}

variable "ami_name" {
  type      = string
  sensitive = true
  default   = env("ami_name")
}

variable "source_ami" {
  type      = string
  sensitive = true
  default   = env("source_ami")
}

variable "instance_type" {
  type      = string
  sensitive = true
  default   = env("instance_type")
}
