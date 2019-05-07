# terraform-hcloud-rke

Terraform module to deploy a Kubernetes Cluster using RKE Provider in Hetzner Cloud.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| count |  | string | `"1"` | no |
| docker\_version |  | string | `"17.03.2"` | no |
| image |  | string | `"ubuntu-16.04"` | no |
| name |  | string | `"node"` | no |
| server\_type |  | string | `"cx21"` | no |
| ssh\_private\_key\_path |  | string | `"~/.ssh/id_rsa"` | no |
| ssh\_public\_key\_path |  | string | `"~/.ssh/id_rsa.pub"` | no |
| user |  | string | `"root"` | no |

## Outputs

| Name | Description |
|------|-------------|
| ipv4\_addresses |  |

