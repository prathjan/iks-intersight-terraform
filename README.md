# iks-intersight-terraform
Intersight IKS provisioning using Terraform Provider

## Use Case Statement
Create an IKS 3-node cluster on vSphere Infrastructure registered with Intersight. 

### Pre-requisites
Please sign up for an account on intersight with access to vSphere infrastructure

### Clone this repository and initialize the provider

The following commands can be used to configure your Terraform environment to use the provider:

```
git clone https://github.com/prathjan/iks-intersight-terraform.git
cd iks-intersight-terraform
terraform init
```

Terraform should report "Terraform has been successfully initialized!" following the "terraform init" command.

### Configure Variables

* Copy over terraform.vars to terraform.tfvars. 
* Log into intersight.com and get the API keys and SecretKey. Include this in the terraform.tfvars file.
* Generate ssh keys and include the public key in the vars file as well

### Plan and Apply

* terraform plan
* terraform apply

### Post provisioning steps

Check for successful deployment of cluster in Intersight portal and download kubeconfig for cluster just created.

