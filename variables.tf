variable "ssh_private_key" {
  description = "SSH private key"
  default     = "~/.ssh/id_rsa"
}

variable "ssh_public_key" {
  description = "SSH public key"
  default     = "~/.ssh/id_rsa.pub"
}

variable "nodes" {
  description = "Map of node objects including their name, role and server_type"
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
  description = "Image"
  type        = string
  default     = "ubuntu-16.04"
}

variable "docker_version" {
  description = "Docker version to install on the nodes"
  type        = string
  default     = "18.06.2"
}

variable "addons_include" {
  description = "List of URLs to yaml resources to include eg. install Kubernetes Dashboard"
  type        = list(string)
  default = [
    "https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml",
    "https://gist.githubusercontent.com/superseb/499f2caa2637c404af41cfb7e5f4a938/raw/930841ac00653fdff8beca61dab9a20bb8983782/k8s-dashboard-user.yml",
  ]
}
