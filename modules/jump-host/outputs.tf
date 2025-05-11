# modules/jump-host/outputs.tf

# Output the name of the created jump host VM.
output "jump_host_name" {
  description = "The name of the jump host VM."
  value       = google_compute_instance.jump_host.name
}

# Output the private IP address of the created jump host VM.
output "jump_host_private_ip" {
  description = "The private IP address of the jump host VM."
  value       = google_compute_instance.jump_host.network_interface[0].network_ip
}
