# terraform-hcloud-rke

Terraform Module to deploy a Kubernetes Cluster using RKE Provider in Hetzner Cloud.

## Usage

See `test/main.tf` for example usage of the module.

After deploying your Kubernetes Cluster you can login to the Kubernetes Dashboard using the following steps:

1. Get Kubernetes Dashboard token

````
kubectl --kubeconfig kube_config_cluster.yml -n kube-system describe secret $(kubectl --kubeconfig kube_config_cluster.yml -n kube-system get secret | grep admin-user | awk '{print $1}') | grep ^token: | awk '{ print $2 }'
````

2. Set up kubectl proxy

````
kubectl --kubeconfig kube_config_cluster.yml proxy"
````

3. Login with the token copied in the step before at http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| addons\_include | List of URLs to yaml resources to include eg. install Kubernetes Dashboard | list(string) | `[ "https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml", "https://gist.githubusercontent.com/superseb/499f2caa2637c404af41cfb7e5f4a938/raw/930841ac00653fdff8beca61dab9a20bb8983782/k8s-dashboard-user.yml" ]` | no |
| docker\_version | Docker version to install on the nodes | string | `"18.06.2"` | no |
| image | Image | string | `"ubuntu-16.04"` | no |
| nodes | Map of node objects including their name, role and server_type | object | `{ "master1": [ { "name": "master1", "role": [ "controlplane", "etcd" ], "server_type": "cx21" } ], "worker1": [ { "name": "worker1", "role": [ "worker" ], "server_type": "cx21" } ] }` | no |
| ssh\_private\_key\_path | SSH private key path | string | `"~/.ssh/id_rsa"` | no |
| ssh\_public\_key\_path | SSH public key path | string | `"~/.ssh/id_rsa.pub"` | no |

## Outputs

| Name | Description |
|------|-------------|
| this | List of node objects |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contributing

We encourage you to contribute to this project in whatever way you like!

## Versioning

[Semantic Versioning 2.x](https://semver.org/)

In a nutshell:

> Given a version number MAJOR.MINOR.PATCH, increment the:
>
> 1. MAJOR version when you make incompatible API changes,
> 2. MINOR version when you add functionality in a backwards-compatible manner, and
> 3. PATCH version when you make backwards-compatible bug fixes.
>
> Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

## Maintainer

https://github.com/brotandgames


