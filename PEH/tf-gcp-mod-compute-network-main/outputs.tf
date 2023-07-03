# VPC network ID as ouput, this is used by other modules
output "vpc_id" {
  value = google_compute_network.this.id
}

# ADDED BY ME
output "subnets" {
  value = google_compute_subnetwork.this
}
