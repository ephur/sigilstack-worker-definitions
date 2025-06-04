output "cloudflare_account_id" {
  value       = data.cloudflare_account.this.account_id
  description = "Cloudflare account ID used for DNS management."
  sensitive   = true
}
