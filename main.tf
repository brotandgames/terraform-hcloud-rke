resource "hcloud_ssh_key" "this" {
  name       = "terraform-hcloud-rke"
  public_key = file(var.ssh_public_key_path)
}

resource "hcloud_server" "this" {
  for_each = var.nodes

  name        = each.value.name
  image       = var.image
  server_type = each.value.server_type

  ssh_keys = [hcloud_ssh_key.this.id]

  provisioner "file" {
    connection {
      host        = self.ipv4_address
      type        = "ssh"
      private_key = file(var.ssh_private_key_path)
    }
    source      = "${path.module}/files/install.sh"
    destination = "/tmp/install.sh"
  }

  provisioner "remote-exec" {
    connection {
      host        = self.ipv4_address
      type        = "ssh"
      private_key = file(var.ssh_private_key_path)
    }
    inline = [
      "chmod +x /tmp/install.sh",
      "/tmp/install.sh ${var.docker_version}",
    ]
  }
}

locals {
  nodes_with_address = [
    for index, node in var.nodes :
    merge(
      node,
      {
        address : hcloud_server.this[index].ipv4_address
      }
    )
  ]
}

resource "rke_cluster" "this" {
  dynamic nodes {
    for_each = local.nodes_with_address
    content {
      address = nodes.value.address
      user    = "root"
      role    = nodes.value.role
      ssh_key = file(var.ssh_private_key_path)
    }
  }

  addons_include = var.addons_include
}
