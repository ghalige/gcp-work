# modules/ssl-certificate/outputs.tf

# Output the name of the created SSL certificate.
output "certificate_name" {
  description = "The name of the SSL certificate."
  value       = google_compute_managed_ssl_certificate.main.name
}

# Output the self-link of the created SSL certificate.
output "certificate_self_link" {
  description = "The self-link of the SSL certificate."
  value       = google_compute_managed_ssl_certificate.main.self_link
}
