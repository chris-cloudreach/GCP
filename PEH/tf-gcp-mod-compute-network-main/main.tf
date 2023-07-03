# In this block, we check if the service_subnet_name_suffix has been set. Otherwise we add
locals {
  name_suffix = var.name_suffix == "" ? "" : "-${var.name_suffix}"
}

# Enabling Service Networking API
resource "google_project_service" "this" {
  project            = var.project_id
  service            = "servicenetworking.googleapis.com"
  disable_on_destroy = false
}

# VPC resource
resource "google_compute_network" "this" {
  project                 = var.project_id
  name                    = "${var.network_name}${local.name_suffix}"
  auto_create_subnetworks = false

  # Checkov rule skips:
  #checkov:skip=CKV2_GCP_18
}

# Private Subnet(s) - general
# This will create as many subnets as specified by the input var.subnet_names_cidrs
resource "google_compute_subnetwork" "this" {
  for_each                 = var.private_subnets
  name                     = "${each.key}${local.name_suffix}"
  ip_cidr_range            = each.value
  project                  = var.project_id
  region                   = var.region
  network                  = google_compute_network.this.id
  private_ip_google_access = true

  # secondary_ip_range {
  #   range_name    = var.pods_ip_range_name
  #   ip_cidr_range = var.pods_ip_range
  # }
  # secondary_ip_range {
  #   range_name    = var.service_ip_range_name
  #   ip_cidr_range = var.service_ip_range
  # }


  log_config {
    aggregation_interval = "INTERVAL_1_MIN"
  }

  # Checkov rule skips:
  #checkov:skip=CKV_GCP_76
}

# Private subnet for Service Connection / Private Services Connect
# Private IP range for private services
resource "google_compute_global_address" "this" {
  count        = var.service_subnet != "" ? 1 : 0
  name         = "private-service-subnet${local.name_suffix}"
  purpose      = "VPC_PEERING"
  address_type = "INTERNAL"

  address       = split("/", var.service_subnet)[0]
  prefix_length = split("/", var.service_subnet)[1]

  project = var.project_id
  network = google_compute_network.this.name
}

# VPC Peering connection for services
resource "google_service_networking_connection" "this" {
  count                   = var.service_subnet != "" ? 1 : 0
  network                 = google_compute_network.this.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.this[0].name]
}

## Cloud NAT and Cloud Routing
# Cloud Router resource
resource "google_compute_router" "this" {
  project = var.project_id
  count   = var.enable_cloud_nat ? 1 : 0
  name    = "${var.project_id}-cloud-router${local.name_suffix}"
  region  = var.region
  network = google_compute_network.this.self_link
}

# Cloud NAT IP addresses
resource "google_compute_address" "nat_ip" {
  project = var.project_id
  count   = var.enable_cloud_nat ? 2 : 0
  name    = "${var.project_id}-cloud-nat-${format("%02s", count.index + 1)}-ip${local.name_suffix}"
  region  = var.region
}

# Cloud Router NAT
resource "google_compute_router_nat" "this" {
  project = var.project_id
  count   = var.enable_cloud_nat ? 1 : 0
  name    = "${var.project_id}-cloud-nat${local.name_suffix}"
  router  = google_compute_router.this[0].name
  region  = var.region

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = google_compute_address.nat_ip[*].self_link

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  dynamic "subnetwork" {
    for_each = google_compute_subnetwork.this
    iterator = subnet
    content {
      name                    = subnet.value.name
      source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
    }
  }

}
