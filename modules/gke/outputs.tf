# modules/gke/outputs.tf

# Output the name of the created GKE cluster.
output "cluster_name" {
  description = "The name of the GKE cluster."
  value       = module.gke_cluster.name
}

# Output the endpoint of the created GKE cluster.
output "cluster_endpoint" {
  description = "The endpoint of the GKE cluster."
  value       = module.gke_cluster.endpoint
}

# Output the CA certificate of the created GKE cluster.
output "cluster_ca_certificate" {
  description = "The CA certificate of the GKE cluster."
  value       = module.gke_cluster.ca_certificate
}

# Output the location (region or zone) of the created GKE cluster.
output "cluster_location" {
  description = "The location (region or zone) of the GKE cluster."
  value       = module.gke_cluster.location
}
