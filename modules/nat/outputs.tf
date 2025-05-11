# modules/nat/outputs.tf

# Output the name of the created NAT gateway.
output "nat_gateway_name" {
  description = "The name of the NAT gateway."
  value       = module.nat_gateway.name
}

# Output the name of the router created by the module.
output "router_name" {
  description = "The name of the router created by the NAT module."
  value       = module.nat_gateway.router_name
}
