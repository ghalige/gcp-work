# modules/nat/main.tf

# This module creates a Cloud NAT gateway and its associated router.
# It uses the official terraform-google-modules/cloud-nat/google module.
# Source: https://github.com/terraform-google-modules/terraform-google-cloud-nat

module "nat_gateway" {
  source  = "terraform-google-modules/cloud-nat/google"
  version = var.module_versions.cloud_nat # Get version from variable

  project_id = var.project_id
  region     = var.region
  network    = var.network_name # Use the network name as input

  # Configure the NAT gateway.
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES" # Or customize as needed
  log_config = {
    enable = true
    filter = "ERRORS_ONLY" # Or "TRANSLATIONS_ONLY", "ALL"
  }

  # Router creation is handled within the module by default if router_id is not provided.
  # The module will create a new router resource if an existing one is not specified.
  # For this configuration, the module will create the router.
}
