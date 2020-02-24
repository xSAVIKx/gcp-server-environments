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

locals {
  instance-tag = "python-runner"
}

module "net-firewall" {
  source = "terraform-google-modules/network/google//modules/fabric-net-firewall"
  project_id = var.project_id
  network = module.network.network_name
  http_source_ranges = []
  https_source_ranges = []
  ssh_source_ranges = []
  custom_rules = {
    allow-interal = {
      description = "Allows Interal Google API calls (e.g. health checks)"
      direction = "INGRESS"
      action = "allow"
      ranges = [
        "10.128.0.0/9"
      ]
      sources = []
      targets = []
      use_service_accounts = false
      rules = [
        {
          protocol = "all"
          ports = []
        }
      ]
      extra_attributes = {
        priority = "65534"
      }
    },
    allow-ssh = {
      description = "Allows internal SSH connections."
      direction = "INGRESS"
      action = "allow"
      ranges = [
        "0.0.0.0/0"
      ]
      sources = []
      targets = []
      use_service_accounts = false
      rules = [
        {
          protocol = "tcp"
          ports = [
            "22"
          ]
        }
      ]
      extra_attributes = {
        priority = "65534"
      }
    },
    allow-icmp = {
      description = "Allows internal ICMP connections."
      direction = "INGRESS"
      action = "allow"
      ranges = [
        "0.0.0.0/0"
      ]
      sources = []
      targets = []
      use_service_accounts = false
      rules = [
        {
          protocol = "icmp"
          ports = []
        }
      ]
      extra_attributes = {
        priority = "65534"
      }
    },
    allow-http-webserver = {
      description = "Allows HTTP connections to the Python Runner instances."
      direction = "INGRESS"
      action = "allow"
      ranges = [
        "0.0.0.0/0"
      ]
      sources = []
      targets = [
        local.instance-tag
      ]
      use_service_accounts = false
      rules = [
        {
          protocol = "tcp"
          ports = [
            "8080"
          ]
        }
      ]
      extra_attributes = {
        priority = "1000"
      }
    }
  }
}