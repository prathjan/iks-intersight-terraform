# Configuring IKS cluster wih Intersight on vSphere Infrastructure 

## Use Case Statement
Create an IKS 3-node cluster using Terraform Intersight Provider on vSphere Infrastructure registered with Intersight. 

### Pre-requisites
Please sign up for an account on intersight.com with access to vSphere infrastructure
You will need to get the Intersight api and secret key.Also, included in this repo is a terraform.vars file that lists 
the configuration items to be filled in for the IKS cluster and copied over to terraform.tfvars.

### Clone this repository and initialize the provider

The following commands can be used to configure your Terraform environment to use the provider:

```
git clone https://github.com/prathjan/iks-intersight-terraform.git
cd iks-intersight-terraform
terraform init
```

Terraform should report "Terraform has been successfully initialized!" following the "terraform init" command.

### Configure Variables

* Copy over terraform.vars to terraform.tfvars.Modify the configuration parameters as needed. The configuration specifies the names of your cluster pools, policies and VM profile that can be modified. You can also change the size of your cluster in the config file.You can also check the Intersight API and reference docs for details on these configuration parameters.
* Log into intersight.com and get the API keys and SecretKey. Include this in the terraform.tfvars file.
* Generate ssh keys and include the public key in the vars file as well

### IKS Configuration
The main configuration file is cprofile.tf which configures a profile for the k8s cluster, create the master and worker node profile and references the cluster profile and finally deploys the cluster

### Validate, Plan and Apply

* terraform validate 
* terraform plan -out example.tfplan. Review the plan to check out the resources to  be provisioned. You should see resources to provision the cluster profile, master/worker node profiles and deploy action for the cluster.
* terraform apply

### Post provisioning steps

Check for successful deployment of cluster in Intersight portal and download kubeconfig for cluster just created.
Check for the cluster node list:
* kubectl --kubeconfig <kubeconfig>.yml get nodes

### Credits
Parts of this README has been taken from https://github.com/CiscoDevNet/intersight-terraform-modules, Credit: David Soper
