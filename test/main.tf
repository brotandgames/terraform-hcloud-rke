module "k8s_cluster" {
  source = "../"

  # Defaults
  #
  # addons_include = [
  # "https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml",
  # "https://gist.githubusercontent.com/superseb/499f2caa2637c404af41cfb7e5f4a938/raw/930841ac00653fdff8beca61dab9a20bb8983782/k8s-dashboard-user.yml"
  # ]
  # docker_version = "18.06.2"
  # image          = "ubuntu-16.04"

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


# If you need kube_config_cluster.yml for using kubectl,
# please uncomment the following local_file resource.

# resource "local_file" "kube_cluster_yaml" {
#   filename          = "${path.root}/kube_config_cluster.yml"
#   sensitive_content = module.k8s_cluster.kube_config_yaml
# }
