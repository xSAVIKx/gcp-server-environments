terraform {
  # This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
  required_version = ">= 0.12"
}
provider "google" {
  version = "3.9.0"
}

provider "google-beta" {}

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

module "network" {
  source = "terraform-google-modules/network/google"
  version = "2.1.1"

  network_name = var.network_name
  project_id = var.project_id
  routing_mode = "REGIONAL"
  subnets = [
    {
      subnet_name = "${var.network_name}-${var.region}-subnet"
      subnet_region = var.region
      subnet_ip = var.cidr_block
    }
  ]
}