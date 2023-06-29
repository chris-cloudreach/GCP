# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
resource "google_compute_subnetwork" "private" {
  name                     = "private"
  ip_cidr_range            = "172.16.0.0/22"
  region                   = "us-central1"
  network                  = google_compute_network.main.id
  private_ip_google_access = true

  # Checkov rule skips:
  #checkov:skip=CKV_GCP_76



  secondary_ip_range {
    range_name    = "k8s-pod-range"
    ip_cidr_range = "172.16.2.0/22"
  }
  secondary_ip_range {
    range_name    = "k8s-service-range"
    ip_cidr_range = "172.16.1.0/22"
  }

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}
