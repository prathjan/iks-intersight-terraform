# Configuring IKS cluster wih Intersight on vSphere Infrastructure 
Parts of this README has been taken from https://github.com/CiscoDevNet/intersight-terraform-modules, Credit: David Soper
Intersight IKS provisioning using Terraform Provider

## Use Case Statement
Create an IKS 3-node cluster using Terraform Intersight Provider on vSphere Infrastructure registered with Intersight. 

### Pre-requisites
Please sign up for an account on intersight.com with access to vSphere infrastructure

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

### IKS Configuration
The main configuration file is cprofile.tf which configures a profile for the k8s cluster, create the master and worker node profile and references the cluster profile and finally deploys the cluster

### Validate, Plan and Apply

* terraform validate 
* terraform plan
* terraform apply

### Post provisioning steps

Check for successful deployment of cluster in Intersight portal and download kubeconfig for cluster just created.
Check for the cluster node list:
* kubectl --kubeconfig <kubeconfig>.yml get nodes

