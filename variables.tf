variable "ssh_private_key_path" {
  description = "SSH private key path"
  default     = "~/.ssh/id_rsa"
}

variable "ssh_public_key_path" {
  description = "SSH public key path"
  default     = "~/.ssh/id_rsa.pub"
}

variable "nodes" {
  description = "Map of node objects including their name, role and server_type"
  type = map(object({
    name              = string,
    role              = list(string),
    server_type       = string,
    node_name         = string,
    hostname_override = string
  }))
  default = {
    master1 = {
      name              = "master1"
      role              = ["controlplane", "etcd"]
      server_type       = "cx21"
      node_name         = "master1"
      hostname_override = "worker2"
    },
    worker1 = {
      name              = "worker1"
      role              = ["worker"]
      server_type       = "cx21"
      node_name         = "worker1"
      hostname_override = "worker1"
    }
  }
}

variable "image" {
  description = "Image"
  type        = string
  default     = "ubuntu-20.04"
}

variable "docker_version" {
  description = "Docker version to install on the nodes"
  type        = string
  default     = "19.03.13"
}

variable "addons_include" {
  description = "List of URLs to yaml resources to include eg. install Kubernetes Dashboard"
  type        = list(string)
  default = [
    "https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml",
    "https://gist.githubusercontent.com/superseb/499f2caa2637c404af41cfb7e5f4a938/raw/930841ac00653fdff8beca61dab9a20bb8983782/k8s-dashboard-user.yml",
  ]
}
