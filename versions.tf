terraform {
  required_version = "~> 1.0"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.31"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.1"
    }
    rke = {
      source  = "rancher/rke"
      version = "~> 1.2"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1"
    }
  }
}
