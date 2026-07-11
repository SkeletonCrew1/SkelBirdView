resource "aws_route53_record" "load_balancer" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = var.record_name
  type    = "A"
  ttl     = "300"

  alias {
    name                   = aws_instance.load-balancer.dns_name
    zone_id                = aws_instance.load-balancer.zone_id
    evaluate_target_health = true
  }


}
