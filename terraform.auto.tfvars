# 
# Example .tfvars file
# Can be copied to terraform.tfvars and edited so that Terraform will automatically use variables from this file.
#
api_key_id = "5fdcc5627564612d33b78e10/6021b2b47564612d33df625a/6025d3c37564612d330677ec"
api_private_key = "/Users/prathjan/Downloads/SecretKey.txt"
endpoint = "https://intersight.com"
mgmtcfgsshkeys = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJkPIkcSWkLxdEeMCTr3eMB7L20GEQpIfKDlvoPHGe6f prathjan@PRATHJAN-M-T39V"
name = "sandcloud"


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
mastergrpname = "sbcloud-master-pool"
masterdesiredsize = 1
workergrpname = "sbcloud-worker-pool"
workerdesiredsize = 2




