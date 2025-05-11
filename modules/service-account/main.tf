# modules/service-account/main.tf

# This module creates a GCP service account and assigns specified project-level roles.
# It uses the official terraform-google-modules/service-accounts/google module.
# Source: https://github.com/terraform-google-modules/terraform-google-service-accounts

module "service_account" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "~> 4.0" # Use a specific version

  project_id   = var.project_id
  names        = [var.service_account_name]
  display_name = "Service Account for ${var.service_account_name}"
  description  = "Service account used for creating infrastructure in ${var.project_id}"

  # Assign project-level roles directly using the module's input variable.
  # The module handles the creation of google_project_iam_member resources internally.
  project_roles = var.project_roles
}

# Removed the separate google_project_iam_member resource as roles are now handled by the module.
