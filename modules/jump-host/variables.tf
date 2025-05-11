# modules/jump-host/variables.tf

# Variable for the GCP project ID.
variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

# Variable for the zone where the jump host will be created.
variable "zone" {
  description = "The zone for the jump host."
  type        = string
}

# Variable for the desired name of the jump host VM.
variable "jump_host_name" {
  description = "The name for the jump host VM."
  type        = string
}

# Variable for the machine type of the jump host VM.
variable "jump_host_machine_type" {
  description = "The machine type for the jump host VM."
  type        = string
}

# Variable for the boot disk size of the jump host VM in GB.
variable "jump_host_disk_size_gb" {
  description = "The boot disk size for the jump host VM in GB."
  type        = number
}

# Variable for the name of the VPC network the jump host will be attached to.
variable "network_name" {
  description = "The name of the VPC network."
  type        = string
}

# Variable for the name of the subnet where the jump host will be created.
variable "jump_host_subnet_name" {
  description = "The name of the subnet for the jump host."
  type        = string
}

# Variable for the email of the service account to be used by the jump host VM.
variable "service_account_email" {
  description = "The email of the service account for the jump host VM."
  type        = string
}
