# GCP

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.3.6 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.71.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | 4.71.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.71.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | 4.71.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_container_cluster.primary](https://registry.terraform.io/providers/hashicorp/google-beta/4.71.0/docs/resources/google_container_cluster) | resource |
| [google_compute_address.nat](https://registry.terraform.io/providers/hashicorp/google/4.71.0/docs/resources/compute_address) | resource |
| [google_compute_firewall.allow-ssh](https://registry.terraform.io/providers/hashicorp/google/4.71.0/docs/resources/compute_firewall) | resource |
| [google_compute_network.main](https://registry.terraform.io/providers/hashicorp/google/4.71.0/docs/resources/compute_network) | resource |
| [google_compute_router.router](https://registry.terraform.io/providers/hashicorp/google/4.71.0/docs/resources/compute_router) | resource |
| [google_compute_router_nat.nat](https://registry.terraform.io/providers/hashicorp/google/4.71.0/docs/resources/compute_router_nat) | resource |
| [google_compute_subnetwork.private](https://registry.terraform.io/providers/hashicorp/google/4.71.0/docs/resources/compute_subnetwork) | resource |
| [google_container_node_pool.spot](https://registry.terraform.io/providers/hashicorp/google/4.71.0/docs/resources/container_node_pool) | resource |
| [google_service_account.kubernetes](https://registry.terraform.io/providers/hashicorp/google/4.71.0/docs/resources/service_account) | resource |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/4.71.0/docs/data-sources/project) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
