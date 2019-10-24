resource "hcloud_ssh_key" "this" {
  name       = "terraform-hcloud-rke"
  public_key = file(var.ssh_public_key_path)
}

data "template_file" "this" {
  template = file("${path.module}/files/install.sh.tpl")

  vars = {
    DOCKER_VERSION = var.docker_version
  }
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
    content     = data.template_file.this.rendered
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
      "/tmp/install.sh",
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

  addons_include = [
    "https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml",
    "https://gist.githubusercontent.com/superseb/499f2caa2637c404af41cfb7e5f4a938/raw/930841ac00653fdff8beca61dab9a20bb8983782/k8s-dashboard-user.yml",
  ]
}

resource "local_file" "kube_cluster_yaml" {
  filename          = "${path.root}/kube_config_cluster.yml"
  sensitive_content = rke_cluster.this.kube_config_yaml
}

