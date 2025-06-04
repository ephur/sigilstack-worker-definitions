variable "ssm_parameter" {
  type = string
  sensitive = false
}

variable "seed_value" {
  type = string
  sensitive = false
}

resource "aws_ssm_parameter" "force_seed" {
  data_type = "text"
  description = "Force seed injected externally"
  insecure_value       = var.seed_value
  overwrite = true
  name        = var.ssm_parameter
  type        = "String"
}
