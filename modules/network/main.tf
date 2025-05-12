# modules/network/main.tf

# This module creates a VPC network and subnets.
# It uses the official terraform-google-modules/network/google module.
# Source: https://github.com/terraform-google-modules/terraform-google-network

module "vpc_network" {
  source  = "terraform-google-modules/network/google"
  version = var.module_versions.network # Get version from variable

  project_id   = var.project_id
  network_name = var.network_name
  routing_mode = "GLOBAL" # Or "REGIONAL" depending on your needs

  # Create subnets based on the provided list.
  subnets = var.subnets

  # Configure secondary ranges for subnets.
  # The module handles associating secondary ranges with the correct subnet.
  secondary_ip_ranges = flatten([
    for subnet in var.subnets : [
      for range in lookup(subnet, "secondary_ip_range", []) : {
        subnet_name   = subnet.subnet_name
        range_name    = range.range_name
        ip_cidr_range = range.ip_cidr_range
      }
    ]
  ])

  # Firewall rules
  firewall_rules = [
    {
      name        = "allow-internal-ssh"
      description = "Allow internal SSH within the VPC"
      direction   = "INGRESS"
      priority    = 65500
      ranges      = [var.network_cidr] # Allow from any IP within the VPC
      allow = [
        {
          protocol = "tcp"
          ports    = ["22"]
        },
      ]
    },
    # The IAP-specific firewall rule is now handled by the official bastion-host module.
    # If you still need direct SSH from trusted IPs, you can uncomment and keep the previous rule:
    # {
    #   name        = "allow-ssh-from-trusted-ips"
    #   description = "Allow SSH from trusted external IP ranges to jump host"
    #   direction   = "INGRESS"
    #   priority    = 1000 # Higher priority than internal rules
    #   ranges      = var.jump_host_ssh_source_ranges # Allow from specified trusted IPs
    #   target_tags = ["jump-host"] # Apply this rule only to VMs with the 'jump-host' tag
    #   allow = [
    #     {
    #       protocol = "tcp"
    #       ports    = ["22"]
    #     },
    #   ]
    # },
    # Optional: Allow egress from bastion host subnet to GKE control plane (private IP)
    # You might need to adjust the target tags and destination ranges based on your GKE setup
    # {
    #   name        = "allow-bastion-host-to-gke-control-plane"
    #   description = "Allow traffic from bastion host subnet to GKE control plane"
    #   direction   = "EGRESS"
    #   priority    = 1000
    #   source_ranges = [lookup(var.subnets_by_name, var.bastion_host_subnet_name).ip_cidr_range] # Source is the bastion host subnet
    #   destination_ranges = ["<GKE_CONTROL_PLANE_PRIVATE_IP_RANGE>"] # Replace with your GKE control plane private IP range
    #   allow = [
    #     {
    #       protocol = "tcp"
    #       ports    = ["443"] # GKE master port
    #     },
    #   ]
    # }
  ]
}
