/**
# terraform-hcloud-rke

Terraform module to deploy a Kubernetes Cluster using RKE Provider in Hetzner Cloud.

*/

resource "hcloud_ssh_key" "this" {
  name = "terraform-hcloud-rke"
  public_key = "${file(var.ssh_public_key_path)}"
}

data "template_file" "this" {
  template = "${file("${path.module}/files/install.tpl")}"

  vars {
    DOCKER_VERSION = "${var.docker_version}"
  }
}

resource "hcloud_server" "this" {
  count = "${var.count}"

  name  = "${format("%s%d", var.name, count.index + 1)}"
  image = "${var.image}"
  server_type  = "${var.server_type}"

  ssh_keys = ["${hcloud_ssh_key.this.id}"]

  provisioner "file" {
    connection {
      private_key = "${file("${var.ssh_private_key_path}")}"
    }
    content      = "${data.template_file.this.rendered}"
    destination  = "/tmp/install.sh"
  }

  provisioner "remote-exec" {
    connection {
      private_key = "${file("${var.ssh_private_key_path}")}"
    }
    inline = [
      "chmod +x /tmp/install.sh",
      "/tmp/install.sh",
    ]
  }
}

data "rke_node_parameter" "this" {
  count   = "${var.count}"

  address      = "${element(hcloud_server.this.*.ipv4_address, count.index)}"
  user         = "${var.user}"
  ssh_key_path = "${var.ssh_private_key_path}"

  role = ["controlplane", "worker", "etcd"]
}

resource "rke_cluster" "this" {
  nodes_conf = ["${data.rke_node_parameter.this.*.json}"]
  
  addons_include = [
    "https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml",
    "https://gist.githubusercontent.com/superseb/499f2caa2637c404af41cfb7e5f4a938/raw/930841ac00653fdff8beca61dab9a20bb8983782/k8s-dashboard-user.yml",
  ]
}

resource "local_file" "kube_cluster_yaml" {
  filename = "${path.root}/kube_config_cluster.yml"
  sensitive_content = "${rke_cluster.this.kube_config_yaml}"
}
