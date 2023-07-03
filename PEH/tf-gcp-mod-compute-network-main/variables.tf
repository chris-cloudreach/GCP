variable "project_id" {
  type        = string
  description = "The project id where the network will be deployed."
}

variable "region" {
  type        = string
  description = "The region name"
}

variable "network_name" {
  type        = string
  description = "The VPC network's name"
}

variable "private_subnets" {
  type        = map(any)
  description = <<-EOT
  Map of subnet names, and their CIDR ranges to be created. Unset by default.
  Example usage:
  ```private_subnets = {
      subnet-01: "10.10.1.0/24"
      subnet-02: "10.10.2.0/24"
      subnet-02: "10.10.3.0/24
    }```
  EOT
  default     = {}
}

# # GKE secondary CIDR ranges
# variable "pods_ip_range" {
#   type        = string
#   description = "Secondary CIDR range for pods."
# }
# variable "service_ip_range" {
#   type        = string
#   description = "Secondary CIDR range for services."
# }
# variable "pods_ip_range_name" {
#   type        = string
#   description = "Name of secondary CIDR range for pods."
# }
# variable "service_ip_range_name" {
#   type        = string
#   description = "Name of secondary CIDR range for services."
# }

variable "service_subnet" {
  type        = string
  description = "CIDR range for the private connection service subnet"
  default     = ""
}

variable "name_suffix" {
  type        = string
  description = "Value to append to the end of resources."
  default     = ""

}

variable "enable_cloud_nat" {
  type        = bool
  description = "Whether to create Cloud NAT and Cloud Routing"
  default     = false
}
