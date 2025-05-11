# modules/iap-access/variables.tf

# Variable for the GCP project ID.
variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

# Variable for the zone of the jump host instance.
variable "zone" {
  description = "The zone of the jump host instance."
  type        = string
}

# Variable for the name of the jump host instance.
variable "instance_name" {
  description = "The name of the jump host instance."
  type        = string
}

# Variable for the list of members (users, groups, service accounts) to grant the role.
variable "members" {
  description = "List of members (users, groups, service accounts) to grant the IAP Tunnel User role."
  type        = list(string)
}
