# modules/iap-access/main.tf

# This module grants the IAP-Secured Tunnel User role to specified members
# on the jump host VM instance.
# It uses the google_compute_instance_iam_member resource.
# Source: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_compute_instance_iam_member

resource "google_compute_instance_iam_member" "iap_tunnel_users" {
  for_each = toset(var.members)

  project  = var.project_id
  zone     = var.zone
  instance = var.instance_name
  role     = "roles/iap.tunnelResourceAccessor"
  member   = each.key
}
