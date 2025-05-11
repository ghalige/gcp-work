# modules/dns/outputs.tf

# Output the name of the created DNS managed zone.
output "zone_name" {
  description = "The name of the DNS managed zone."
  value       = module.dns_zone.zone_name
}

# Output the DNS name of the created zone.
output "dns_name" {
  description = "The DNS name of the zone."
  value       = module.dns_zone.dns_name
}

# Output the name servers for the created zone.
output "name_servers" {
  description = "The name servers for the zone."
  value       = module.dns_zone.name_servers
}
