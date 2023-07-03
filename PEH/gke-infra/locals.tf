locals {
  project_id = data.google_project.project.project_id
  region     = "europe-west2"

  gke_cluster_name      = "platform-engineering"
  gke-master-ipv4-range = "172.16.0.0/28"
  Spot_nodepool_name    = "platform-engineering-spot-nodepool"
  pods-ip-range         = "10.196.0.0/14"
  service-ip-range      = "10.200.240.0/20"
  image_type            = "COS_CONTAINERD"
  pods-per-node         = 150

  GKE_vpc_name = "gke-vpc"
  subnet_name  = "gke-subnet-tgha2"
  route        = "gke-route-tgha2"

}
