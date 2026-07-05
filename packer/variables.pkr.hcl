variable "datadog_api_key" {
  type      = string
  sensitive = true
  default   = env("datadog_api_key")
}

variable "datadog_site" {
  type      = string
  sensitive = true
  default   = env("datadog_site")
}

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
