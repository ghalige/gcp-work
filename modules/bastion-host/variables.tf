# modules/bastion-host/variables.tf

# Variable for the GCP project ID.
variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

# Variable for the zone where the bastion host will be created.
variable "zone" {
  description = "The zone for the bastion host."
  type        = string
}

# Variable for the desired name of the bastion host VM.
variable "bastion_host_name" {
  description = "The name for the bastion host VM."
  type        = string
}

# Variable for the machine type of the bastion host VM.
variable "bastion_host_machine_type" {
  description = "The machine type for the bastion host VM."
  type        = string
}

# Variable for the boot disk size of the bastion host VM in GB.
variable "bastion_host_disk_size_gb" {
  description = "The boot disk size for the bastion host VM in GB."
  type        = number
}

# Variable for the name of the VPC network the bastion host will be attached to.
variable "network_name" {
  description = "The name of the VPC network."
  type        = string
}

# Variable for the name of the subnet where the bastion host will be created.
variable "bastion_host_subnet_name" {
  description = "The name of the subnet for the bastion host."
  type        = string
}

# Variable for the list of members (users, groups, service accounts) to grant IAP Tunnel User role.
variable "bastion_host_iap_users" {
  description = "List of members (users, groups, service accounts) to grant the IAP Tunnel User role."
  type        = list(string)
}

# Optional: Variable for the email of the service account to be used by the bastion host VM.
# variable "service_account_email" {
#   description = "The email of the service account for the bastion host VM."
#   type        = string
#   default     = null # Set to null if not assigning a specific SA
# }

# Variable for module versions (read from terragrunt locals)
variable "module_versions" {
  description = "Map of module versions."
  type        = map(string)
}
