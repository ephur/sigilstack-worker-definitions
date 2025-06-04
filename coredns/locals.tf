locals {
  domain_record_count = length(data.dns_txt_record_set.domains.records)
  domain_list_ok      = local.domain_record_count >= var.minimum_viable
  force_apply_seed    = var.force_apply ? uuid() : one(data.aws_ssm_parameter.force_seed[*].value)
}
