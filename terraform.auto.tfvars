# 
# Example .tfvars file
# Can be copied to terraform.tfvars and edited so that Terraform will automatically use variables from this file.
#
name = "tfsandbox"


# profile params
# IP Pool name and moid 
ippool_list = "Galaxy1050b"

# Netcfg name
netcfg_list = "gffa-cluster-1-network-policy"
# Syscfg name
syscfg_list = "gffa-cluster-1-sys-config-policy"
infra_list = "SandboxInfra1000"
#infra_list = "Sandbox_Vcenter_ESXi"
ippoolmaster_list = "Galaxy1050b"
ippoolworker_list = "Galaxy1050b"
kubever_list = "Kubernetes-1.18"
orgobjtype = "organization.Organization"
mgmtcfgetcd = false
mgmtcfglbcnt = 1
mgmtcfgsshuser = "iksadmin"
mastergrpname = "tfsb-master-pool1"
masterdesiredsize = 1
workergrpname = "tfsb-worker-pool1"
workerdesiredsize = 2




