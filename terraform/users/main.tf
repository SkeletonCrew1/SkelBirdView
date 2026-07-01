locals {
  user_policy_pairs = {
    for pair in setproduct(var.users, var.policies_arns) :
    "${pair[0]}-${pair[1]}" => {
      user   = pair[0]
      policy = pair[1]
    }
  }
}

resource "aws_iam_user" "main" {
  for_each = toset(var.users)

  name = each.value
  path = "/"

  tags = {
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_user_login_profile" "main" {
  for_each = aws_iam_user.main

  user                    = each.value.name
  password_length         = 20
  password_reset_required = true

}

resource "aws_iam_user_policy_attachment" "main" {
  for_each = local.user_policy_pairs

  user       = aws_iam_user.main[each.value.user].name
  policy_arn = each.value.policy
}

resource "aws_iam_user" "flask-user" {
  name = "flask-application"
  path = "/"

  tags = {
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_user_policy_attachment" "flask-user" {
  user = aws_iam_user.flask-user.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_access_key" "flask-user" {
  user = aws_iam_user.flask-user.id
}

resource "aws_iam_access_key" "jenkins_user" {
  user = aws_iam_user.main["jenkins_user"].id
}
