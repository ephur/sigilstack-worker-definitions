output "aws_zone_names" {
  description = "Names of all AWS Route53 zones created"
  value       = [for z in aws_route53_zone.domains : z.name]
}

output "cloudflare_zone_names" {
  description = "Names of all Cloudflare zones created"
  value       = [for z in cloudflare_zone.domains : z.zone]
}

output "all_zone_names" {
  description = "Combined list of all zone names"
  value       = distinct(concat(
    [for z in aws_route53_zone.domains : z.name],
    [for z in cloudflare_zone.domains : z.zone]
  ))
}

output "force_seed_ack" {
  description = "Module replied to our existential infrastructure inquiry."
  value       = module.write_force_seed.was_this_even_necessary
}
