output "packer_user_access_key" {
  value = {
    id = aws_iam_access_key.packer-key.id
    secret = aws_iam_access_key.packer-key.secret
  }
  sensitive = true
}