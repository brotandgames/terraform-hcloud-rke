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

resource "local_file" "kube_cluster_yaml" {
  filename          = "${path.root}/kube_config_cluster.yml"
  sensitive_content = rke_cluster.this.kube_config_yaml
}


resource "hcloud_network" "this" {
  name = "terraform-hcloud-rke-${path.module}"
  ip_range = "10.98.0.0/16"
}

resource "hcloud_network_subnet" "this" {
  network_id = hcloud_network.this.id
  type = "server"
  ip_range = hcloud_network.this.ip_range
  network_zone = "eu-central"
}
  
resource "hcloud_server_network" "this" {
  for_each = var.nodes
  
  server_id = hcloud_server.this[each.key].id
  network_id = hcloud_network.this.id
}
