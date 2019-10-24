# terraform-hcloud-rke

Terraform Module to deploy a Kubernetes Cluster using RKE Provider in Hetzner Cloud.

## Usage

See `test/main.tf`

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| docker\_version |  | string | `"18.06.2"` | no |
| image |  | string | `"ubuntu-16.04"` | no |
| nodes |  | object | `{ "master1": [ { "name": "master1", "role": [ "controlplane", "etcd" ], "server_type": "cx21" } ], "worker1": [ { "name": "worker1", "role": [ "worker" ], "server_type": "cx21" } ] }` | no |
| ssh\_private\_key\_path |  | string | `"~/.ssh/id_rsa"` | no |
| ssh\_public\_key\_path |  | string | `"~/.ssh/id_rsa.pub"` | no |

## Outputs

| Name | Description |
|------|-------------|
| this |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
