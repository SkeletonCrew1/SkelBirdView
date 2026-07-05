locals {
  users = [
    "Roman_Misiuryn",
    "Vitalii_Oliinyk",
    "Denis_Folyush",
    "Maksym_Semehen",
    "Oleh_Konovaliuk"
  ]

  policies_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",               # EC2 full access
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",                # S3 full access
    "arn:aws:iam::aws:policy/AmazonVPCFullAccess",               # VPC full access
    "arn:aws:iam::aws:policy/AWSKeyManagementServicePowerUser",  # KMS access
    "arn:aws:iam::aws:policy/IAMReadOnlyAccess",                 # IAM read only
    "arn:aws:iam::aws:policy/IAMUserChangePassword",             # IAM user change password, required as users have to change their password on the first login
    "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess",          # CloudWatch read only access
    "arn:aws:iam::aws:policy/AWSBillingReadOnlyAccess",          # AWS billing read only access
    "arn:aws:iam::aws:policy/AWSAccountManagementReadOnlyAccess" # AWS account management read only access
  ]

  user_policy_pairs = {
    for pair in setproduct(local.users, local.policies_arns) :
    "${pair[0]}-${pair[1]}" => {
      user   = pair[0]
      policy = pair[1]
    }
  }
}