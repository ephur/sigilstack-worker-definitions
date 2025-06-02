variable "ssm_parameter" { type = string }
variable "seed_value"    { type = string }

resource "aws_ssm_parameter" "force_seed" {
  name        = var.ssm_parameter
  type        = "String"
  value       = var.seed_value
  description = "Force seed injected externally"
}
