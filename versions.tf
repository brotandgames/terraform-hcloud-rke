terraform {
  required_version = ">= 0.13"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.23"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
    rke = {
      source  = "rancher/rke"
      version = "~> 1.1"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }

}
