resource "google_container_node_pool" "spot" {
  name              = local.Spot_nodepool_name
  cluster           = google_container_cluster.this.id
  max_pods_per_node = local.pods-per-node

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    total_min_node_count = 1
    total_max_node_count = 3
  }

  node_config {
    machine_type = "n2-standard-4"

    spot        = true
    preemptible = false

    image_type = local.image_type

    labels = {
      type = "spot_nodepool"
    }

    workload_metadata_config {
      mode = "GKE_METADATA"
    }
    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }

    service_account = google_service_account.GKE_Service_Account.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
