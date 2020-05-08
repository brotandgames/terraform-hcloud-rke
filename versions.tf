terraform {
  required_version = ">= 0.12"

  required_providers {
    hcloud   = "~> 1.14"
    local    = "~> 1.4"
    rke      = "~> 1.0"
    template = "~> 2.1"
    null     = "~> 2.1"
  }

}
