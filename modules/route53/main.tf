data "aws_route53_zone" "public_zone" {
  name         = var.domain
  private_zone = false
}

resource "aws_route53_record" "cloudfront_record" {
  zone_id = data.aws_route53_zone.public_zone.zone_id
  name    = data.aws_route53_zone.public_zone.name
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_hosted_zone_id
    evaluate_target_health = false
  }
}