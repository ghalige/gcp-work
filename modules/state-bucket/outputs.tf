# modules/state-bucket/outputs.tf

# Output the name of the created state bucket.
output "bucket_name" {
  description = "The name of the state bucket."
  value       = module.state_bucket.name
}

# Output the self-link of the created state bucket.
output "bucket_self_link" {
  description = "The self-link of the state bucket."
  value       = module.state_bucket.self_link
}
