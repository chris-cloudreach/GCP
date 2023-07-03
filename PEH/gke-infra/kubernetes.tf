resource "google_container_cluster" "this" {
  provider                 = google
  name                     = local.gke_cluster_name
  location                 = local.region
  remove_default_node_pool = true
  initial_node_count       = 1

  default_max_pods_per_node = local.pods-per-node

  network    = module.google_gke_network.vpc_id
  subnetwork = "projects/${local.project_id}/regions/${local.region}/subnetworks/${local.subnet_name}"

  networking_mode             = "VPC_NATIVE"
  enable_intranode_visibility = true

  enable_shielded_nodes = true

  binary_authorization {
    evaluation_mode = "PROJECT_SINGLETON_POLICY_ENFORCE"
  }

  logging_config {
    enable_components = [
      "SYSTEM_COMPONENTS",
      "WORKLOADS",
    ]
  }

  # # update SG
  # authenticator_groups_config {
  #   security_group = "gke-security-groups@dft.gov.uk"
  # }

  resource_labels = {
    "infra" = "github-runner"

  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  addons_config {
    http_load_balancing {
      disabled = true
    }

    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  node_config {
    service_account = google_service_account.GKE_Service_Account.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    image_type = local.image_type
    spot       = true

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

  # Pod security already enabled by default on clusters running 1.25+
  # https://cloud.google.com/kubernetes-engine/docs/how-to/migrate-podsecuritypolicy

  monitoring_config {
    enable_components = [
      "SYSTEM_COMPONENTS",
      "APISERVER",
      "CONTROLLER_MANAGER",
      "SCHEDULER"
    ]

    managed_prometheus {
      enabled = true
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "${data.google_project.project.project_id}.svc.id.goog"
  }

  cost_management_config {
    enabled = true
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = local.pods-ip-range
    services_ipv4_cidr_block = local.service-ip-range
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = local.gke-master-ipv4-range
  }


}
