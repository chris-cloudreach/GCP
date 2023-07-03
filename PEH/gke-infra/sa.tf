resource "google_service_account" "GKE_Service_Account" {
  account_id   = "gke-platform-engineering"
  display_name = "GKE Service Account"
}
