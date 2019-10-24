variable "ssh_private_key_path" {
  default = "~/.ssh/id_rsa"
}

variable "ssh_public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "nodes" {
  type = map(object({
    name        = string,
    role        = list(string),
    server_type = string,
  }))
  default = {
    master1 = {
      name        = "master1"
      role        = ["controlplane", "etcd"]
      server_type = "cx21"
    },
    worker1 = {
      name        = "worker1"
      role        = ["worker"]
      server_type = "cx21"
    },
  }
}

variable "image" {
  default = "ubuntu-16.04"
}

variable "docker_version" {
  default = "18.06.2"
}
