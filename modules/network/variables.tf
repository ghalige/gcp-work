# modules/network/variables.tf

# Variable for the GCP project ID.
variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

# Variable for the desired name of the VPC network.
variable "network_name" {
  description = "The name for the VPC network."
  type        = string
}

# Variable for the CIDR range of the VPC network (used for internal firewall rules).
variable "network_cidr" {
  description = "The CIDR range of the VPC network."
  type        = string
}

# Variable for the list of subnets to create.
# Each subnet object should have:
# - subnet_name: The name of the subnet.
# - subnet_ip: The primary IP CIDR range for the subnet.
# - subnet_region: The region for the subnet.
# - description: A description for the subnet.
# - secondary_ip_range (optional): A list of secondary IP ranges for the subnet.
#   Each secondary range object should have:
#   - range_name: The name of the secondary range.
#   - ip_cidr_range: The IP CIDR range for the secondary range.
variable "subnets" {
  description = "List of subnets to create."
  type = list(object({
    subnet_name        = string
    subnet_ip          = string
    subnet_region      = string
    description        = string
    secondary_ip_range = optional(list(object({
      range_name    = string
      ip_cidr_range = string
    })), [])
  }))
}

# Variable for the name of the subnet where the bastion host will be created.
variable "bastion_host_subnet_name" {
  description = "The name of the subnet for the bastion host."
  type        = string
}

# Variable for the source IP range(s) for SSH access to the bastion host (if not using IAP).
# variable "jump_host_ssh_source_ranges" {
#   description = "List of trusted IP ranges for SSH access to the bastion host (if not using IAP)."
#   type        = list(string)
#   default     = []
# }

# Variable for the map of subnet names to subnet objects (used for firewall rule source ranges).
variable "subnets_by_name" {
  description = "Map of subnet names to subnet objects."
  type        = map(any) # Using 'any' because the structure is complex, but could be more specific
}
