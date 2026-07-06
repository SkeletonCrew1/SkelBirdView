resource "aws_iam_user" "users" {
  for_each = toset(local.users)

  name = each.value
  path = "/"

  tags = {
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_user_login_profile" "users" {
  for_each = aws_iam_user.users

  user                    = each.value.name
  password_length         = 20
  password_reset_required = true

}

resource "aws_iam_user_policy_attachment" "users" {
  for_each = local.user_policy_pairs

  user       = aws_iam_user.users[each.value.user].name
  policy_arn = each.value.policy
}

resource "aws_iam_user" "jenkins-user" {
  name = "jenkins-user"
  path = "/"

  tags = {
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_user_policy_attachment" "jenkins-user" {
  for_each = local.user_policy_pairs

  user = aws_iam_user.jenkins-user.id
  policy_arn = each.value.policy
}


resource "aws_iam_access_key" "jenkins-user" {
  user = aws_iam_user.jenkins-user.id
}

resource "aws_iam_user" "flask-user" {
  name = "flask-application"
  path = "/"

  tags = {
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_user_policy_attachment" "flask-user" {
  user       = aws_iam_user.flask-user.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_access_key" "flask-user" {
  user = aws_iam_user.flask-user.id
}
