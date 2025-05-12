# modules/bastion-host/main.tf

# This module creates a bastion host VM with IAP access.
# It uses the official terraform-google-modules/bastion-host/google module.
# Source: https://github.com/terraform-google-modules/terraform-google-bastion-host

module "bastion_host" {
  source  = "terraform-google-modules/bastion-host/google"
  version = var.module_versions.bastion_host # Get version from variable

  project_id   = var.project_id
  zone         = var.zone
  name         = var.bastion_host_name
  machine_type = var.bastion_host_machine_type
  disk_size_gb = var.bastion_host_disk_size_gb
  network      = var.network_name
  subnet       = var.bastion_host_subnet_name

  # Configure IAP access for the bastion host.
  # The module handles granting the 'roles/iap.tunnelResourceAccessor' role
  # to the specified members and creating the necessary firewall rule.
  enable_iap = true
  iap_users  = var.bastion_host_iap_users

  # Optional: Configure OS Login
  # enable_oslogin = true

  # Optional: Configure service account for the VM
  # service_account = var.service_account_email # Uncomment and pass SA email if needed
  # service_account_scopes = ["cloud-platform"] # Adjust scopes as needed

  # Optional: Add additional metadata
  # metadata = {
  #   ssh-keys = "user:ssh-rsa AAAAB3Nz..." # Add your SSH public key here if not using OS Login
  # }

  # Optional: Add network tags
  # network_tags = ["bastion-host", "ssh"]
}
