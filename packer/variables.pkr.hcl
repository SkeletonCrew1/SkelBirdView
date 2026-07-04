variable "DATADOG_API_KEY" {
  type      = string
  sensitive = true
  default   = env("DATADOG_API_KEY")
}

variable "DATADOG_SITE" {
  type      = string
  sensitive = true
  default   = env("DATADOG_SITE")
}
