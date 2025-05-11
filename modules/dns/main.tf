# modules/dns/main.tf

# This module creates a Cloud DNS managed zone.
# It uses the official terraform-google-modules/cloud-dns/google module.
# Source: https://github.com/terraform-google-modules/terraform-google-cloud-dns

module "dns_zone" {
  source  = "terraform-google-modules/cloud-dns/google"
  version = "~> 3.0" # Use a specific version

  project_id  = var.project_id
  zone_name   = var.dns_zone_name
  dns_name    = var.dns_name
  description = "Managed DNS zone for ${var.dns_name}"

  # Optional: Configure private visibility for VPC networks
  # If using private zones, uncomment and provide the network name
  # network_names = var.dns_network_name != null ? [var.dns_network_name] : []

  # Optional: Configure DNSSEC
  # dnssec_config = {
  #   state = "on"
  #   default_key_specs = [
  #     {
  #       key_type = "keySigning"
  #       algorithm = "rsasha512"
  #       key_length = 2048
  #     },
  #     {
  #       key_type = "zoneSigning"
  #       algorithm = "rsasha512"
  #       key_length = 2048
  #     },
  #   ]
  # }
}
