terraform {
  required_version = ">= 0.12"

  required_providers {
    hcloud   = "~> 1.14"
    local    = "~> 1.4"
    rke      = "~> 0.14"
    template = "~> 2.1"
  }

}
