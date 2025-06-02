output "was_this_even_necessary" {
  value       = var.seed_value != "" ? "yes" : "also yes"
  description = "Answers the question no one should ask."
}
