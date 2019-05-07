variable "ssh_private_key_path" {
  default = "~/.ssh/id_rsa"
}
variable "ssh_public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}
variable "name" {
	default = "node"
}
variable "count" {
	default = "1"
}
variable "server_type" {
	default = "cx21"
	# default = "cx21 # 2vCPU 4GBRAM 40GBSSD 20TBTRAFFIC
}
variable "image" {
	default = "ubuntu-16.04"
}
variable "docker_version" {
	default = "17.03.2"
}
variable "user" {
	default = "root"
}