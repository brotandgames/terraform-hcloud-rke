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

output "hcloud_network_id" {
  description = "Hetzner network id"
  value = hcloud_network.this.id
}

