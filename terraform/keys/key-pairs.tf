resource "aws_key_pair" "deployer" {
  for_each = local.ssh-public-keys

  key_name   = each.key
  public_key = each.value
}