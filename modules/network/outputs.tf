# modules/network/outputs.tf

# Output the name of the created VPC network.
output "network_name" {
  description = "The name of the VPC network."
  value       = module.vpc_network.network_name
}

# Output the self-link of the created VPC network.
output "network_self_link" {
  description = "The self-link of the VPC network."
  value       = module.vpc_network.self_link
}

# Output the self-links of the created subnets.
output "subnets_self_links" {
  description = "The self-links of the subnets."
  value       = module.vpc_network.subnets_self_links
}

# Output the names of the created subnets.
output "subnets_names" {
  description = "The names of the subnets."
  value       = module.vpc_network.subnets_names
}

# Output the map of subnet names to self-links.
output "subnets_by_name" {
  description = "Map of subnet names to self links."
  value       = module.vpc_network.subnets_by_name
}

# Output the map of subnet names to secondary IP ranges.
output "subnets_secondary_ranges" {
  description = "Map of subnet names to secondary IP ranges."
  value       = module.vpc_network.subnets_secondary_ranges
}
