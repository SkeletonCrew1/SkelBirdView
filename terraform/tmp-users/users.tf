resource "aws_iam_user" "packer" {
  name = "packer-user"
  path = "/"

  tags = {
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_user_policy_attachment" "packer-ec2" {
  user = aws_iam_user.packer.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_access_key" "packer-key" {
  user = aws_iam_user.packer.id
}
