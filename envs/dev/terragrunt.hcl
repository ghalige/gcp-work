# envs/qa/terragrunt.hcl

# Include the common configuration from the root terragrunt.hcl.
include {
  path = find_in_parent_folders()
}

# Define the modules to deploy for the 'qa' environment.

# 1. State Bucket
# This module needs to be applied first to set up the remote state backend.
terraform {
  source = "../../modules/state-bucket"
  extra_arguments "bucket_vars" {
    commands = ["apply", "plan", "destroy", "validate", "init", "refresh", "import", "taint", "untaint", "fmt", "graph", "output", "state", "show", "force-unlock", "get", "providers", "version", "workspace"]
    arguments = [
      "-var=project_id=${local.inputs.project_id}",
      "-var=state_bucket_name=${local.inputs.state_bucket_name}",
      "-var=region=${local.inputs.region}",
    ]
  }
}

# 2. Service Account
# This module creates the service account and assigns project-level roles.
module "service_account" {
  source = "../../modules/service-account"
  inputs = {
    project_id           = local.inputs.project_id
    service_account_name = local.inputs.service_account_name
    # Pass project_roles from root terragrunt locals if defined in vars file,
    # otherwise the module's default project_roles will be used.
    project_roles = local.inputs.project_roles
  }
}

# 3. Network (VPC and Subnets)
# This module creates the VPC network, subnets, and firewall rules.
module "network" {
  source = "../../modules/network"
  inputs = {
    project_id                = local.inputs.project_id
    network_name              = local.inputs.network_name
    network_cidr              = local.inputs.network_cidr
    subnets                   = local.inputs.subnets
    bastion_host_subnet_name  = local.inputs.bastion_host_subnet_name # Pass bastion subnet name
    # jump_host_ssh_source_ranges = local.inputs.jump_host_ssh_source_ranges # Keep if needed for non-IAP access
    subnets_by_name           = local.inputs.subnets_by_name
  }
  # Ensure network is created after the service account (if service account is used for network creation).
  # dependencies = [module.service_account]
}

# 4. NAT Gateway
# This module creates the Cloud NAT gateway and its associated router.
module "nat" {
  source = "../../modules/nat"
  inputs = {
    project_id   = local.inputs.project_id
    region       = local.inputs.region
    network_name = local.inputs.network_name # Use the network name output from the network module
  }
  # Ensure NAT is created after the network.
  dependencies = [module.network]
}

# 5. GKE Cluster
# This module creates the GKE standard cluster with specified node pools and configurations.
module "gke" {
  source = "../../modules/gke"
  inputs = {
    project_id              = local.inputs.project_id
    gke_cluster_name        = local.inputs.gke_cluster_name
    region                  = local.inputs.region
    zone                    = local.inputs.zone
    network_name            = local.inputs.network_name # Use the network name output
    subnet_name             = local.inputs.subnet_name # Use the specific subnet name for GKE nodes
    ip_range_pods_name      = local.inputs.ip_range_pods_name # Use the secondary range name for pods
    ip_range_services_name  = local.inputs.ip_range_services_name # Use the secondary range name for services
    service_account_email   = module.service_account.outputs.service_account_email # Use the service account email output
    gke_node_pools          = local.inputs.gke_node_pools
  }
  # Ensure GKE is created after the network and service account.
  dependencies = [module.network, module.service_account]
}

# 6. Cloud DNS Managed Zone (using official module)
module "dns" {
  source = "../../modules/dns" # Point to the local module wrapper
  inputs = {
    project_id    = local.inputs.project_id
    dns_zone_name = local.inputs.dns_zone_name
    dns_name      = local.inputs.dns_name
    dns_network_name = local.inputs.dns_network_name # Pass optional network name
  }
  # DNS can typically be created independently or depend on the project.
  # dependencies = [module.service_account] # Optional dependency if SA is needed for DNS creation
}

# 7. Bastion Host VM (using official module)
module "bastion_host" {
  source = "../../modules/bastion-host" # Point to the local module wrapper
  inputs = {
    project_id             = local.inputs.project_id
    zone                   = local.inputs.zone
    bastion_host_name      = local.inputs.bastion_host_name
    bastion_host_machine_type = local.inputs.bastion_host_machine_type
    bastion_host_disk_size_gb = local.inputs.bastion_host_disk_size_gb
    network_name           = local.inputs.network_name # Use the network name output
    bastion_host_subnet_name  = local.inputs.bastion_host_subnet_name
    bastion_host_iap_users = local.inputs.bastion_host_iap_users
    # service_account_email  = module.service_account.outputs.service_account_email # Uncomment if assigning a specific SA
  }
  # Ensure the bastion host is created after the network.
  dependencies = [module.network]
}

# Removed the separate iap-access module as it's handled by the bastion-host module.
