# modules/state-bucket/main.tf

# This module creates a Cloud Storage bucket for Terraform state.
# It uses the official terraform-google-modules/cloud-storage/google module.
# Source: https://github.com/terraform-google-modules/terraform-google-cloud-storage

module "state_bucket" {
  source  = "terraform-google-modules/cloud-storage/google"
  version = var.module_versions.cloud_storage # Get version from variable

  project_id = var.project_id
  names       = var.state_bucket_name
  location   = var.region

  # Enable versioning to keep a history of your state files.
  versioning = {
    enabled = true
  }

  # Lifecycle rule to manage old versions (optional but recommended).
  lifecycle_rules = [
    {
      action = {
        type = "Delete"
      }
      condition = {
        age = 365 # Delete versions older than 365 days
      }
    }
  ]

  # Prevent accidental deletion of the bucket (optional but recommended).
  force_destroy = false

  # Set uniform bucket-level access for consistent permissions.
  uniform_bucket_level_access = true
}
