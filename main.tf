terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option

variable "do_token" {
  type        = string
  description = "Your Digital Ocean API Token"
  # No default value specified here since it's sensitive information
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_kubernetes_cluster" "doks" {
  name   = "anne-cluster"
  region = "nyc1"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.28.2-do.0"

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-4gb"
    node_count = 3
  }
}

variable "image" {
  type        = string
  description = "Image for the DigitalOcean API Token"
  default     = "dop_v1_ad58c53e5e94ebaf3d29cc224bfa77343bc668afec9690f8f3d86f35bc5795f3"
}

