resource "google_compute_router" "router" {
  name    = local.route
  region  = local.region
  network = module.google_gke_network.vpc_id
}
