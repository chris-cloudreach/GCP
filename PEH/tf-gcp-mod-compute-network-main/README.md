# tf-gcp-mod-compute-network-main

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.53.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.53.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_address.nat_ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_global_address.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_network.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_router.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_nat.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat) | resource |
| [google_compute_subnetwork.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_project_service.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_networking_connection.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_cloud_nat"></a> [enable\_cloud\_nat](#input\_enable\_cloud\_nat) | Whether to create Cloud NAT and Cloud Routing | `bool` | `false` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | Value to append to the end of resources. | `string` | `""` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | The VPC network's name | `string` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | Map of subnet names, and their CIDR ranges to be created. Unset by default.<br>Example usage:<pre>private_subnets = {<br>    subnet-01: "10.10.1.0/24"<br>    subnet-02: "10.10.2.0/24"<br>    subnet-02: "10.10.3.0/24<br>  }</pre> | `map(any)` | `{}` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project id where the network will be deployed. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region name | `string` | n/a | yes |
| <a name="input_service_subnet"></a> [service\_subnet](#input\_service\_subnet) | CIDR range for the private connection service subnet | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnets"></a> [subnets](#output\_subnets) | ADDED BY ME |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC network ID as ouput, this is used by other modules |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
