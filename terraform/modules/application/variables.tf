variable "region" {
  type = string
}

variable "lb_instance_type" {
  type = string
}

variable "lb_subnet_id" {
  type = string
}

variable "lb_iam_instance_profile" {
  type = string
}

variable "lb_name" {
  type = string
}

variable "lb_ami" {
  type = string
}

variable "web_instances_count" {
  type = string
}

variable "web_ami" {
  type = string
}

variable "web_instance_type" {
  type = string
}

variable "web_subnet_id" {
  type = string
}

variable "web_iam_instance_profile" {
  type = string
}

variable "web_name" {
  type = string
}

variable "db_ami" {
  type = string
}

variable "db_instance_type" {
  type = string
}

variable "db_subnet_id" {
  type = string
}

variable "db_iam_instance_profile" {
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

variable "custom_vpc_id" {
  type = string
}

variable "developers_vpc_cidr" {
  type = string
}

variable "domain_name" {
  description = "The domain name for the hosted zone"
  type        = string
  default     = "birdview.pp.ua"
}

variable "record_name" {
  description = "The name of the record to create"
  type        = string
  default     = "Birdwatching"
}
