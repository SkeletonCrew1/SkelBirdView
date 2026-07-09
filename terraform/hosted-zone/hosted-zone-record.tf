
resource "aws_route53_record" "example" {
  zone_id = aws_route53_zone.example.zone_id
  name    = "birdview.pp.ua"
  type    = "A"
  ttl     = "300"
  records = aws_instance.load_balancer.public_ip

}
