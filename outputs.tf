output "this" {
  description = "List of node objects"
  value = [
    for index, node in var.nodes :
    merge(
      node,
      hcloud_server.this[index]
    )
  ]
}


output "kube_config_path" {
  description = "Contents of the kube_config file"
  value = local_file.kube_cluster_yaml.filename
}

output "api_server_url" {
  description = "URL of the Kubernetes API server"
  value = rke_cluster.this.api_server_url
}

output "client_cert" {
  description = "Admin client certificate"
  value = rke_cluster.this.client_cert
}

output "client_key" {
  description = "Admin client key"
  value = rke_cluster.this.client_key
}

output "ca_cert" {
  description = "Cluster CA Certificate"
  value = rke_cluster.this.ca_crt
}

