output "ipv4_addresses" {
  value = ["${hcloud_server.this.*.ipv4_address}"]
}
