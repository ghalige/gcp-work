# modules/ssl-certificate/variables.tf

# Variable for the GCP project ID.
variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

# Variable for the desired name of the SSL certificate.
variable "ssl_certificate_name" {
  description = "The name for the SSL certificate."
  type        = string
}

# Variable for the list of domains the certificate will cover.
variable "ssl_domains" {
  description = "List of domains for the SSL certificate."
  type        = list(string)
}
