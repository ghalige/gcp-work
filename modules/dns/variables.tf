# modules/dns/variables.tf

# Variable for the GCP project ID.
variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

# Variable for the desired name of the DNS managed zone.
variable "dns_zone_name" {
  description = "The name for the DNS managed zone (must be unique within the project)."
  type        = string
}

# Variable for the DNS name of the zone (e.g., "example.com.").
variable "dns_name" {
  description = "The DNS name for the zone (must end with a dot)."
  type        = string
}

# Optional: Variable for the VPC network name if using private DNS zones.
variable "dns_network_name" {
  description = "The name of the VPC network for private DNS zones."
  type        = string
  default     = null # Set to null if not using private zones
}

# Variable for module versions (read from terragrunt locals)
variable "module_versions" {
  description = "Map of module versions."
  type        = map(string)
}
