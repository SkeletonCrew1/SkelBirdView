variable "users" {
  type        = set(string)
  description = "A set of IAM usernames"
}

variable "policies_arns" {
  type        = set(string)
  description = "A set of ARNs to provide for each user"
}