resource "null_resource" "validate_domain_record_count" {
  # This resource ensures the number of domains seems reasonable before proceeding to break everything.
  triggers = {
    domain_record_count = local.domain_record_count
  }

  lifecycle {
    precondition {
      condition     = local.domain_list_ok
      error_message = "FATAL: Only ${local.domain_record_count} domains found — minimum required is ${var.minimum_viable}."
    }
  }
}

data "dns_txt_record_set" "domains" {
  host = "_domains.ephur.net"
}

locals {
  filtered_aws_domains = [
    for d in data.dns_txt_record_set.domains.records : d
    if contains(local.aws_domains, element(
      split(".", d), length(split(".", d)) - 2)
    )
  ]

  filtered_cloudflare_domains = [
    for d in data.dns_txt_record_set.domains.records : d
    if contains(local.cloudflare_domains, element(
      split(".", d), length(split(".", d)) - 2)
    )
  ]
}

resource "cloudflare_zone" "domains" {
  for_each = { for d in local.filtered_cloudflare_domains : d => d
  }

  name = each.value
  type = "full"

  account = {
    id = data.cloudflare_account.this.account_id
  }
}

resource "aws_route53_zone" "domains" {
  for_each = { for d in local.filtered_aws_domains : d => d
  }

  name = each.value
  comment = "Managed by SigilStack"
}

data "aws_ssm_parameter" "force_seed" {
  name  = "/sigilstack/definitions/coredns/force_seed"
}

module "write_force_seed" {
  source        = "./force_seed"
  ssm_parameter = "/sigilstack/definitions/coredns/force_seed"
  seed_value    = local.force_apply_seed
}
