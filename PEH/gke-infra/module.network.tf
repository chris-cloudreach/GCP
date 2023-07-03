# Needs subnetwork in its output besides vpc_id
module "google_gke_network" {
  # source = "git@github.com:department-for-transport-IaC/tf-gcp-mod-compute-network?ref=v1.2.0"
  source = "../tf-gcp-mod-compute-network-main"

  enable_cloud_nat = false
  network_name     = local.GKE_vpc_name

  private_subnets = {
    (local.subnet_name) : "10.0.0.0/22",
  }

  project_id = data.google_project.project.project_id

  region = local.region

}
