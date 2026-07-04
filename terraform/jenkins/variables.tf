variable "vpc_state_bucket" {
  type = string
}

variable "vpc_state_key" {
  type = string
}

variable "instance_type" {
  default = "c7i-flex.large"
}

variable "key_name" {
  default = "vitalii-key"
}