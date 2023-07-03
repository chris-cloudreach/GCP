# resource "google_compute_network" "main" {
#   name                            = local.GKE_vpc_name
#   routing_mode                    = "REGIONAL"
#   auto_create_subnetworks         = false
#   mtu                             = 1460
#   delete_default_routes_on_create = false
# }

# resource "google_compute_subnetwork" "private" {
#   name                     = local.GKE_subnetwork_name
#   ip_cidr_range            = "10.0.0.0/22"
#   region                   = local.region
#   network                  = google_compute_network.main.id
#   private_ip_google_access = true

#   # Checkov rule skips:
#   #checkov:skip=CKV_GCP_76

#   secondary_ip_range {
#     range_name    = "k8s-pod-range"
#     ip_cidr_range = "10.0.4.0/22"
#   }
#   secondary_ip_range {
#     range_name    = "k8s-service-range"
#     ip_cidr_range = "10.0.8.0/22"
#   }

#   log_config {
#     aggregation_interval = "INTERVAL_1_MIN"
#     flow_sampling        = 0.5
#     metadata             = "INCLUDE_ALL_METADATA"
#   }
# }
