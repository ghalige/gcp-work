# modules/state-bucket/variables.tf

# Variable for the GCP project ID.
variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

# Variable for the desired name of the state bucket.
variable "state_bucket_name" {
  description = "The name for the state bucket."
  type        = string
}

# Variable for the region where the state bucket will be created.
variable "region" {
  description = "The region for the state bucket."
  type        = string
}
