# modules/gke/main.tf

# This module creates a GKE standard cluster with specified configurations.
# It uses the official terraform-google-modules/kubernetes-engine/google module.
# Source: https://github.com/terraform-google-modules/terraform-google-kubernetes-engine

module "gke_cluster" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "~> 28.0" # Use a specific version

  project_id                = var.project_id
  name                      = var.gke_cluster_name
  region                    = var.region
  zone                      = var.zone # Specify a zone within the region
  network                   = var.network_name
  subnetwork                = var.subnet_name # Use the name of the subnet where GKE nodes will reside
  ip_range_pods             = var.ip_range_pods_name
  ip_range_services         = var.ip_range_services_name
  service_account           = var.service_account_email

  # GKE Cluster Configuration
  remove_default_node_pool = true # Remove the default node pool
  initial_node_count       = null # Set initial_node_count to null when removing default pool

  # Private Cluster Configuration
  enable_private_endpoint = true
  enable_private_nodes    = true
  master_ipv4_cidr_block  = "172.16.0.0/28" # Private CIDR for master endpoint

  # IP Allocation Policy (VPC-native)
  ip_allocation_policy = {
    cluster_ipv4_cidr_block       = "" # Use secondary ranges
    services_ipv4_cidr_block      = "" # Use secondary ranges
    cluster_secondary_range_name  = var.ip_range_pods_name
    services_secondary_range_name = var.ip_range_services_name
  }

  # Features
  enable_network_policy = true # Recommended for production
  enable_http_load_balancing = true # Enable HTTP Load Balancing add-on
  enable_autopilot = false # Not Autopilot, standard cluster
  enable_vertical_pod_autoscaling = true # Recommended for production

  # Release Channel
  release_channel = "REGULAR" # Or "RAPID", "STABLE"

  # Node Pools
  node_pools = var.gke_node_pools

  # Node Pool Defaults (applied to all node pools unless overridden)
  node_pool_defaults = {
    machine_type = "e2-medium" # Default machine type
    disk_size_gb = 50
    disk_type    = "pd-standard"
    auto_upgrade = true
    auto_repair  = true
    # Configure node pool autoscaling defaults
    autoscaling = {
      enabled          = true
      min_node_count   = 1
      max_node_count   = 3
      location_policy  = "BALANCED"
      cpu_utilization = null # Use default CPU utilization
      # Add other autoscaling configurations as needed
    }
  }

  # Add-ons
  addons_config = {
    http_load_balancing = {
      disabled = false # Explicitly enable HTTP Load Balancing
    }
    network_policy_config = {
      disabled = false # Explicitly enable Network Policy
    }
    # Add other add-ons as needed
  }

  # Enable Gateway API
  gateway_api_channel = "CHANNEL_STANDARD" # Or "CHANNEL_EXPERIMENTAL"

  # Configure log exports (optional but recommended)
  logging_config = {
    enable_components = ["system_components", "workloads"]
  }
  monitoring_config = {
    enable_components = ["system_components"]
  }

  # Master Authorized Networks (optional but recommended for private clusters)
  # master_authorized_networks_config = {
  #   cidr_blocks = [
  #     {
  #       cidr_block   = "0.0.0.0/0" # Replace with your trusted IP ranges
  #       display_name = "Allow All (Replace with your IPs)"
  #     },
  #   ]
  # }

  # Workload Identity (optional but recommended)
  # workload_identity_config = {
  #   # Configure Workload Identity if needed
  # }
}
