# modules/service-account/variables.tf

# Variable for the GCP project ID.
variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

# Variable for the service account name.
variable "service_account_name" {
  description = "The name of the service account to create."
  type        = string
}

# Variable for the list of roles to grant to the service account at the project level.
# These roles are assigned by the module internally.
variable "project_roles" {
  description = "List of roles to grant to the service account at the project level."
  type        = list(string)
  default = [
    "roles/owner" # Consider using more granular roles for production
  ]
}
