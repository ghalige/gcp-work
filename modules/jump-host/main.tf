# modules/jump-host/main.tf

# This module creates a jump host VM with a private IP address.
# It uses the google_compute_instance resource.
# Source: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_compute_instance

resource "google_compute_instance" "jump_host" {
  project      = var.project_id
  zone         = var.zone
  name         = var.jump_host_name
  machine_type = var.jump_host_machine_type

  # Use a Debian or Ubuntu image for the boot disk
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11" # Or "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = var.jump_host_disk_size_gb
    }
  }

  # Configure the network interface with a private IP from the specified subnet.
  # Omitting the 'access_config' block ensures no external IP is assigned.
  network_interface {
    network    = var.network_name
    subnetwork = var.jump_host_subnet_name
    # Optional: Assign a specific private IP address
    # network_ip = "10.1.1.100" # Replace with a desired IP within the subnet's range
  }

  # Assign the service account to the VM.
  # Consider creating a dedicated service account with minimal permissions for the jump host.
  service_account {
    email  = var.service_account_email
    scopes = ["cloud-platform"] # Consider using more granular scopes
  }

  # Add tags to the VM for firewall rules and identification.
  tags = ["jump-host", "${var.jump_host_name}"]

  # Allow SSH access via OS Login (recommended) or metadata keys.
  # Ensure OS Login is enabled at the project level or add SSH keys via metadata.
  metadata = {
    # ssh-keys = "user:ssh-rsa AAAAB3Nz..." # Add your SSH public key here if not using OS Login
  }

  # Optional: Configure scheduling options
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  # Optional: Configure deletion protection
  # deletion_protection = true
}
