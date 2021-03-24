# 
# Example .tfvars file
# Can be copied to terraform.tfvars and edited so that Terraform will automatically use variables from this file.
#
name = "TempPoolSB"
# profile params
# IP Pool name and moid 
ippool_list = "TempPool"

# Netcfg name
netcfg_list = "gffa-cluster-1-network-policy"
# Syscfg name
syscfg_list = "gffa-cluster-1-sys-config-policy"
infra_list = "Sandbox_Vcenter_ESXi"
ippoolmaster_list = "TempPool"
ippoolworker_list = "TempPool"
kubever_list = "Kubernetes-1.18"
orgobjtype = "organization.Organization"
mgmtcfgetcd = false
mgmtcfglbcnt = 3
mgmtcfgsshuser = "iksadmin"
mastergrpname = "temppool-master-pool1"
masterdesiredsize = 1
workergrpname = "temppool-worker-pool1"
workerdesiredsize = 1




