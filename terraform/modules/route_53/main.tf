resource "aws_route53_record" "www" {
  zone_id = var.hosted_zone_id
  name    = ""
  type    = "A"
  ttl     = 300
  records = [var.load_balancer_public_ip]
}