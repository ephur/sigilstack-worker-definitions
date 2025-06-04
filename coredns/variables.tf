variable "cloudflare_account_name" {
  description = "Name of the Cloudflare account to use for DNS management"
  type        = string
}

variable "force_apply" {
  description = "If true, generates a unique value to force apply. If false, uses a stable value from external source."
  type        = bool
  default     = false
}

variable "minimum_viable" {
  description = "Minimum number of domain records required to proceed"
  type        = number
  default     = 5
  validation {
    condition     = var.minimum_viable > 0
    error_message = "FATAL: Willful and wanton destruction of the entire sigilstack is not allowed. Please set minimum_viable to a positive integer."
  }
}
