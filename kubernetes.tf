# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
resource "google_container_cluster" "primary" {
  provider                 = google-beta
  name                     = "primary"
  location                 = "us-central1-a"
  remove_default_node_pool = true
  initial_node_count       = 1
  # max_pods_per_node           = 250
  network    = google_compute_network.main.self_link
  subnetwork = google_compute_subnetwork.private.self_link
  # logging_service          = "logging.googleapis.com/kubernetes"
  # monitoring_service       = "monitoring.googleapis.com/kubernetes"
  networking_mode = "VPC_NATIVE"

  enable_intranode_visibility = true

  # Checkov rule skips:
  #checkov:skip=CKV_GCP_21
  #checkov:skip=CKV_GCP_24
  #checkov:skip=CKV_GCP_66
  #checkov:skip=CKV_GCP_67
  #checkov:skip=CKV_GCP_65

  min_master_version = "1.26.5-gke.1200"
  # min_master_version = "1.27.2-gke.2100"
  # master_version = "1.23.17-gke.7700"


  enable_shielded_nodes = true

  # enable_binary_authorization = true
  binary_authorization {
    # first enable binary authorisation API in console
    # enabled = true
    evaluation_mode = "PROJECT_SINGLETON_POLICY_ENFORCE"
  }

  logging_config {
    enable_components = [
      "SYSTEM_COMPONENTS",
      "WORKLOADS",
    ]
  }

  # REMOVE THIS LINE
  # authenticator_groups_config {
  #   security_group = "gke-security-groups@yourdomain.com"
  # }

  master_auth {
    client_certificate_config {
      issue_client_certificate = true
    }
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.0.0.0/16"
      display_name = "master_authorized_CIDR"
    }
  }

  # Optional, if you want multi-zonal cluster
  node_locations = [
    "us-central1-b"
  ]

  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  node_config {
    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    # image_type = "COS"
    image_type = "COS_CONTAINERD"

    labels = {
      type = "Github_Runner_Infrastructure"
    }

    workload_metadata_config {
      mode = "GKE_METADATA"
    }
    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }
  }

  network_policy {
    enabled = true
  }
  # REMOVED FROM GKE VERSION 1.25+
  # ALREADY ENABLED BY DEFAULT ON CLUSTERS RUNNING 1.25+
  # https://cloud.google.com/kubernetes-engine/docs/how-to/migrate-podsecuritypolicy
  # pod_security_policy_config {
  #   enabled = true
  # }

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS", "APISERVER", "CONTROLLER_MANAGER", "SCHEDULER"]

    managed_prometheus {
      enabled = true
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    # workload_pool = "cr-lab-cogbunuzor-2806235940.svc.id.goog"
    workload_pool = "${data.google_project.project.project_id}.svc.id.goog"

  }

  cost_management_config {
    enabled = true
  }

  # resource_usage_export_config {
  #   enable_network_egress_metering = true
  #   enable_resource_consumption_metering = true
  #   bigquery_destination {
  #     dataset_id = "mymeteringdataset"
  #     }
  # }

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-range"
    services_secondary_range_name = "k8s-service-range"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }
}
