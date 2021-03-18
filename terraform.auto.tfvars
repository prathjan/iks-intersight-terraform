# 
# Example .tfvars file
# Can be copied to terraform.tfvars and edited so that Terraform will automatically use variables from this file.
#
endpoint = "https://intersight.com"
name = "tfcloud3"


# profile params
# IP Pool name and moid 
ippool_list = "GFFA-HX2-1051"

# Netcfg name
netcfg_list = "gffa-cluster-1-network-policy"
# Syscfg name
syscfg_list = "gffa-cluster-1-sys-config-policy"
infra_list = "GFFA_HX2-1051"
ippoolmaster_list = "GFFA-HX2-1051"
ippoolworker_list = "GFFA-HX2-1051"
kubever_list = "Kubernetes-1.18"
orgobjtype = "organization.Organization"
mgmtcfgetcd = false
mgmtcfglbcnt = 1
mgmtcfgsshuser = "iksadmin"
mastergrpname = "tfcloud3-master-pool1"
masterdesiredsize = 1
workergrpname = "tfcloud3-worker-pool1"
workerdesiredsize = 2




