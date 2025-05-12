# modules/gke/variables.tf

# Variable for the GCP project ID.
variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

# Variable for the desired name of the GKE cluster.
variable "gke_cluster_name" {
  description = "The name for the GKE cluster."
  type        = string
}

# Variable for the region where the GKE cluster will be created.
variable "region" {
  description = "The region for the GKE cluster."
  type        = string
}

# Variable for the zone where the GKE cluster will be created.
variable "zone" {
  description = "The zone for the GKE cluster."
  type        = string
}

# Variable for the name of the VPC network the GKE cluster will use.
variable "network_name" {
  description = "The name of the VPC network."
  type        = string
}

# Variable for the name of the subnet where GKE nodes will reside.
variable "subnet_name" {
  description = "The name of the subnet for GKE nodes."
  type        = string
}

# Variable for the name of the secondary IP range for GKE pods.
variable "ip_range_pods_name" {
  description = "The name of the secondary IP range for GKE pods."
  type        = string
}

# Variable for the name of the secondary IP range for GKE services.
variable "ip_range_services_name" {
  description = "The name of the secondary IP range for GKE services."
  type        = string
}

# Variable for the email of the service account to be used by GKE nodes.
variable "service_account_email" {
  description = "The email of the service account for GKE nodes."
  type        = string
}

# Variable for the configuration of the GKE node pools.
variable "gke_node_pools" {
  description = "List of GKE node pool configurations."
  type = list(object({
    name           = string
    machine_type   = string
    node_count     = number
    min_node_count = number
    max_node_count = number
    disk_size_gb   = number
    disk_type      = string
    auto_upgrade   = bool
    auto_repair    = bool
    # Add other node pool configurations as needed (e.g., taints, labels, tags)
  }))
}

# Variable for module versions (read from terragrunt locals)
variable "module_versions" {
  description = "Map of module versions."
  type        = map(string)
}
