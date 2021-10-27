# terraform-hcloud-rke

Terraform Module to deploy a Kubernetes Cluster using RKE Provider in Hetzner Cloud.

## Usage

See `test/main.tf` for example usage of the module.

You might want to include the CSI driver for automatic provisioning of volumes by adding `https://raw.githubusercontent.com/hetznercloud/csi-driver/v1.2.3/deploy/kubernetes/hcloud-csi.yml` to `addons_include` variable. (Note: A configmap containing the api key needs to be added as well.)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | ~> 1.31 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.1 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.1 |
| <a name="requirement_rke"></a> [rke](#requirement\_rke) | ~> 1.2 |
| <a name="requirement_template"></a> [template](#requirement\_template) | ~> 2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | 1.31.1 |
| <a name="provider_rke"></a> [rke](#provider\_rke) | 1.2.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [hcloud_server.this](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server) | resource |
| [hcloud_ssh_key.this](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/ssh_key) | resource |
| [rke_cluster.this](https://registry.terraform.io/providers/rancher/rke/latest/docs/resources/cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addons_include"></a> [addons\_include](#input\_addons\_include) | List of URLs to yaml resources to include eg. install Kubernetes Dashboard | `list(string)` | <pre>[<br>  "https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml",<br>  "https://gist.githubusercontent.com/superseb/499f2caa2637c404af41cfb7e5f4a938/raw/930841ac00653fdff8beca61dab9a20bb8983782/k8s-dashboard-user.yml"<br>]</pre> | no |
| <a name="input_docker_version"></a> [docker\_version](#input\_docker\_version) | Docker version to install on the nodes | `string` | `"19.03.13"` | no |
| <a name="input_image"></a> [image](#input\_image) | Image | `string` | `"ubuntu-20.04"` | no |
| <a name="input_nodes"></a> [nodes](#input\_nodes) | Map of node objects including their name, role and server\_type | <pre>map(object({<br>    name              = string,<br>    role              = list(string),<br>    server_type       = string,<br>    node_name         = string,<br>    hostname_override = string<br>  }))</pre> | <pre>{<br>  "master1": {<br>    "hostname_override": "worker2",<br>    "name": "master1",<br>    "node_name": "master1",<br>    "role": [<br>      "controlplane",<br>      "etcd"<br>    ],<br>    "server_type": "cx21"<br>  },<br>  "worker1": {<br>    "hostname_override": "worker1",<br>    "name": "worker1",<br>    "node_name": "worker1",<br>    "role": [<br>      "worker"<br>    ],<br>    "server_type": "cx21"<br>  }<br>}</pre> | no |
| <a name="input_ssh_private_key_path"></a> [ssh\_private\_key\_path](#input\_ssh\_private\_key\_path) | SSH private key path | `string` | `"~/.ssh/id_rsa"` | no |
| <a name="input_ssh_public_key_path"></a> [ssh\_public\_key\_path](#input\_ssh\_public\_key\_path) | SSH public key path | `string` | `"~/.ssh/id_rsa.pub"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_server_url"></a> [api\_server\_url](#output\_api\_server\_url) | RKE k8s cluster api server url |
| <a name="output_ca_cert"></a> [ca\_cert](#output\_ca\_cert) | RKE k8s cluster CA certificate |
| <a name="output_client_cert"></a> [client\_cert](#output\_client\_cert) | RKE k8s cluster client certificate |
| <a name="output_client_key"></a> [client\_key](#output\_client\_key) | RKE k8s cluster client key |
| <a name="output_kube_config_yaml"></a> [kube\_config\_yaml](#output\_kube\_config\_yaml) | RKE k8s cluster kube config yaml |
| <a name="output_this"></a> [this](#output\_this) | List of node objects |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Where to go further?

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

## Contributing

We encourage you to contribute to this project in whatever way you like!

Report bugs/feature requests in the [issues](https://github.com/brotandgames/terraform-hcloud-rke/issues/new/choose) section.

When contributing to this repository, please first discuss the change you wish to make via issue with the owners of this repository before making a change.

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


