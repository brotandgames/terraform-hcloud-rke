variable "hcloud_token" {}

provider "hcloud" {
  token = "${var.hcloud_token}"
}

module "terraform-hcloud-rke" {
  source = "../"
  name   = "node"
  ssh_private_key_path = "./.ssh/id_rsa"
  ssh_public_key_path = "./.ssh/id_rsa.pub"
}

output "ipv4_addresses" {
  value = ["${module.terraform-hcloud-rke.ipv4_addresses}"]
}
