# 
# Example .tfvars file
# Can be copied to terraform.tfvars and edited so that Terraform will automatically use variables from this file.
#
endpoint = "https://intersight.com"
name = "tfcloud2"


# profile params
# IP Pool name and moid 
ippool_list = "Galaxy1050b"

# Netcfg name
netcfg_list = "gffa-cluster-1-network-policy"
# Syscfg name
syscfg_list = "gffa-cluster-1-sys-config-policy"
infra_list = "GFFA-VCenter"
ippoolmaster_list = "Galaxy1050b"
ippoolworker_list = "Galaxy1050b"
kubever_list = "Kubernetes-1.18"
orgobjtype = "organization.Organization"
mgmtcfgetcd = false
mgmtcfglbcnt = 1
mgmtcfgsshuser = "iksadmin"
mastergrpname = "tfcloud2-master-pool"
masterdesiredsize = 1
workergrpname = "tfcloud2-worker-pool"
workerdesiredsize = 2




