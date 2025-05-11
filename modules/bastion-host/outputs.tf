# modules/bastion-host/outputs.tf

# Output the name of the created bastion host VM.
output "bastion_host_name" {
  description = "The name of the bastion host VM."
  value       = module.bastion_host.name
}

# Output the private IP address of the created bastion host VM.
output "bastion_host_private_ip" {
  description = "The private IP address of the bastion host VM."
  value       = module.bastion_host.private_ip
}
