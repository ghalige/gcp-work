# modules/service-account/outputs.tf

# Output the email address of the created service account.
output "service_account_email" {
  description = "The email of the service account."
  value       = module.service_account.emails[0]
}

# Output the unique ID of the created service account.
output "service_account_id" {
  description = "The unique id of the service account."
  value       = module.service_account.ids[0]
}
