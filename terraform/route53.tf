resource "aws_route53_zone" "kb-host-zone" {
  name    = "konbist.work"
  comment = "konbist.work host zone"
}

resource "aws_route53_record" "kb-host-zone-record" {
  zone_id = aws_route53_zone.kb-host-zone.zone_id
  name    = aws_route53_zone.kb-host-zone.name
  type    = "A"

  alias {
    name                   = aws_lb.kb-alb.dns_name
    zone_id                = aws_lb.kb-alb.zone_id
    evaluate_target_health = true
  }
}