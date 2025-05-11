# modules/nat/variables.tf

# Variable for the GCP project ID.
variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

# Variable for the region where the NAT gateway will be created.
variable "region" {
  description = "The region for the NAT gateway."
  type        = string
}

# Variable for the name of the VPC network the NAT gateway will be attached to.
variable "network_name" {
  description = "The name of the VPC network."
  type        = string
}

# Variable for the ID of an existing router if you don't want the module to create one.
# Leave commented out or set to null if you want the module to create the router.
# variable "router_id" {
#   description = "The ID of an existing router to attach the NAT gateway to."
#   type        = string
#   default     = null
# }
