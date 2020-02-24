variable "project_id" {
  description = "GCP project ID to deploy the infrastructure to"
  type = string
}

variable "region" {
  description = "The region in which the infrastructure is deployed to"
  type = string
  default = "us-central1"
}

variable "zone" {
  description = "The zone within the region the managed group is created in"
  type = string
  default = "us-central1-c"
}

variable "network_name" {
  description = "The name of the GCP network used for the runner"
  type = string
  default = "python-runner-network"
}

variable "cidr_block" {
  description = "The IP address range of the VPC in CIDR notation. A prefix of /16 is recommended. Do not use a prefix higher than /27."
  default = "10.0.0.0/16"
  type = string
}