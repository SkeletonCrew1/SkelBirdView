variable "vpc_state_bucket" {
  type = string
}

variable "vpc_state_key" {
  type = string
}

variable "instance_type" {
  default = "t3.micro"
}

variable "vpc_state_region" {
  type = string
}