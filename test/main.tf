module "k8s_cluster" {
  source = "../"

  ssh_private_key_path = "./.ssh/id_rsa"
  ssh_public_key_path  = "./.ssh/id_rsa.pub"

  nodes = {
    master1 = {
      name        = "master1"
      role        = ["controlplane", "etcd"]
      server_type = "cx21"
    },
    worker1 = {
      name        = "worker1"
      role        = ["worker"]
      server_type = "cx21"
    }
  }
}

output "k8s_cluster_this" {
  value = module.k8s_cluster.this
}

###############################################################################
# If you need kube_config_cluster.yml for using kubectl,
# please uncomment follows.
###############################################################################
# resource "local_file" "kube_cluster_yaml" {
#   filename          = "${path.root}/kube_config_cluster.yml"
#   sensitive_content = module.k8s_cluster.kube_config_yaml
# }
