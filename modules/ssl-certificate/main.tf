# modules/ssl-certificate/main.tf

# This module creates a Google-managed SSL certificate using the google_compute_managed_ssl_certificate resource.
# Source: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_compute_managed_ssl_certificate

resource "google_compute_managed_ssl_certificate" "main" {
  project = var.project_id
  name    = var.ssl_certificate_name
  managed {
    domains = var.ssl_domains
  }

  # Optional: Configure certificate type (e.g., REGIONAL, GLOBAL)
  # type = "REGIONAL" # Or "GLOBAL" depending on your load balancer type
}
