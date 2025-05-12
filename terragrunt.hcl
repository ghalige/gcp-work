# terragrunt.hcl (Root)

# Configure Terragrunt to automatically create the remote state bucket if it doesn't exist.
remote_state {
  backend = "gcs"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = include.locals.inputs.state_bucket_name # Use the bucket name from environment inputs
    prefix = path_relative_to_include() # Use the path relative to the include for state file organization
  }
}

# Define locals to load variables from the environment-specific YAML files.
locals {
  # Determine the environment name (e.g., "dev", "qa") from the directory path.
  environment = basename(get_original_terraform_dir())

  # Construct the path to the environment-specific variables file.
  vars_file_path = "${get_parent_dir()}/vars/${local.environment}-vars.yml"

  # Read the variables from the environment-specific YAML file using yamldecode.
  vars = yamldecode(file(local.vars_file_path))

  # Construct the path to the module versions YAML file.
  module_versions_file_path = "${get_parent_dir()}/module-version.yml"

  # Read the module versions from the YAML file using yamldecode.
  module_versions = yamldecode(file(local.module_versions_file_path)).module_versions

  # Define inputs that will be passed to the modules.
  # These inputs are derived from the variables read from the YAML files.
  inputs = {
    project_id          = local.vars.project_id
    region              = local.vars.region
    zone                = local.vars.zone
    network_name        = local.vars.network_name
    network_cidr        = local.vars.network_cidr
    subnets             = local.vars.subnets
    state_bucket_name   = local.vars.state_bucket_name
    service_account_name = local.vars.service_account_name
    # Pass project_roles from vars if defined, otherwise use the module default.
    project_roles       = lookup(local.vars, "service_account_project_roles", null)
    # DNS variables
    dns_zone_name       = local.vars.dns_zone_name
    dns_name            = local.vars.dns_name
    dns_network_name    = lookup(local.vars, "dns_network_name", null) # Optional network for private zones
    # SSL Certificate variables
    ssl_certificate_name = local.vars.ssl_certificate_name
    ssl_domains         = local.vars.ssl_domains
    gke_cluster_name    = local.vars.gke_cluster_name
    gke_node_pools      = local.vars.gke_node_pools
    # Bastion Host variables
    bastion_host_name            = local.vars.bastion_host_name
    bastion_host_machine_type    = local.vars.bastion_host_machine_type
    bastion_host_disk_size_gb    = local.vars.bastion_host_disk_size_gb
    bastion_host_subnet_name     = local.vars.bastion_host_subnet_name
    bastion_host_iap_users       = local.vars.bastion_host_iap_users

    # Module versions map
    module_versions     = local.module_versions

    # Extract the name of the first subnet for the GKE module.
    # Assuming the first subnet in the list is where GKE nodes will reside.
    subnet_name = local.vars.subnets[0].subnet_name

    # Extract the names of the secondary ranges for GKE from the first subnet.
    # Assuming the first subnet has the secondary ranges for GKE.
    ip_range_services_name = local.vars.subnets[0].secondary_ip_range[0].range_name
    ip_range_pods_name     = local.vars.subnets[0].secondary_ip_range[1].range_name

    # Pass the map of subnets by name to the network module for firewall rules
    subnets_by_name = { for s in local.vars.subnets : s.subnet_name => s }
  }
}

# Configure the provider for Google Cloud.
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    provider "google" {
      project = "${local.inputs.project_id}"
      region  = "${local.inputs.region}"
    }
  EOF
}

# Include the common configuration from the root terragrunt.hcl.
# This is included in the environment-specific terragrunt.hcl files.
# This block is primarily for documentation and clarity; the actual inclusion
# happens in the envs/*/terragrunt.hcl files using `include`.
