# Intersight Provider Information 
terraform {
  required_providers {
    intersight = {
      source = "CiscoDevNet/intersight"
      version = "1.0.0"
    }
  }
}

provider "intersight" {
  apikey        = var.api_key_id
  secretkey = var.api_private_key
  endpoint      = var.api_endpoint
}

# Organization and other required Managed Object IDs (moids)
module "intersight-moids" {
  source            = "../intersight-moids"
  organization_name = var.organization_name
}

# IPPool moids
data "intersight_ippool_pool" "ippool_moid" {
  name  = var.ippool_list[count.index].name
  moid = var.ippool_list[count.index].moid
  count = length(var.ippool_list)
}

# Netcfg moids
data "intersight_kubernetes_network_policy" "netcfg_moid" {
  name  = var.netcfg_list[count.index].name
  moid = var.netcfg_list[count.index].moid
  count = length(var.netcfg_list)
}

# Sysconfig moids
data "intersight_kubernetes_sys_config_policy" "syscfg_moid" {
  name  = var.syscfg_list[count.index].name
  moid = var.syscfg_list[count.index].moid
  count = length(var.syscfg_list)
}



# kube cluster profiles
resource "intersight_kubernetes_cluster_profile" "kubeprof" {
  name = var.name 
  count  = length(var.ippool_list)
  organization {
    object_type = "organization.Organization"
    moid        = module.intersight-moids.organization_moid
  }
  cluster_ip_pools {
#	moid = var.ippoolmoid
	object_type = var.ippooltype
	moid = data.intersight_ippool_pool.ippool_moid[count.index].moid
  }
  management_config {
	encrypted_etcd = var.mgmtcfgetcd
	load_balancer_count = var.mgmtcfglbcnt
	ssh_keys = [ 
		 var.mgmtcfgsshkeys
	]
	ssh_user = var.mgmtcfgsshuser
	object_type = var.mgmtcfgobjtype
  }
  net_config {
# moid = var.netcfgmoid	
	moid = data.intersight_kubernetes_network_policy.netcfg_moid[count.index].moid
	object_type = var.netcfgobjtype
  }

  sys_config {
# moid = var.syscfgmoid
	moid = data.intersight_kubernetes_sys_config_policy.syscfg_moid[count.index].moid
	object_type = var.syscfgobjtype 
  }
}


# cluster profile moids
data "intersight_kubernetes_cluster_profile" "cprofile_moid" {
  depends_on = [
        intersight_kubernetes_cluster_profile.kubeprof
  ]
  name  = var.cprofile_list[count.index].name
  moid = var.cprofile_list[count.index].moid
  count = length(var.cprofile_list)
}

# Infra provider moids
data "intersight_kubernetes_virtual_machine_infrastructure_provider" "infra_moid" {
  name  = var.infra_list[count.index].name
  moid = var.infra_list[count.index].moid
  count = length(var.infra_list)
}

# IpPool moids
data "intersight_ippool_pool" "ippoolmaster_moid" {
  name  = var.ippoolmaster_list[count.index].name
  moid = var.ippoolmaster_list[count.index].moid
  count = length(var.ippoolmaster_list)
}

# IpPool moids
data "intersight_ippool_pool" "ippoolworker_moid" {
  name  = var.ippoolworker_list[count.index].name
  moid = var.ippoolworker_list[count.index].moid
  count = length(var.ippoolworker_list)
}

# Kube version moids
data "intersight_kubernetes_version_policy" "kubever_moid" {
  name  = var.kubever_list[count.index].name
  moid = var.kubever_list[count.index].moid
  count = length(var.kubever_list)
}


# Master
resource "intersight_kubernetes_node_group_profile" "masternodegrp" {

  depends_on = [
        intersight_kubernetes_cluster_profile.kubeprof
  ]



  name = var.mastergrpname
  node_type = var.masternodetype
  desiredsize = var.masterdesiredsize

  count  = 1
  ip_pools {
        object_type = var.ippooltype
        moid = data.intersight_ippool_pool.ippoolmaster_moid[count.index].moid
  }


  cluster_profile {
        object_type = var.clusterprofiletype
        moid = data.intersight_kubernetes_cluster_profile.cprofile_moid[count.index].moid
  }


  infra_provider {
        object_type = var.infratype
        moid = data.intersight_kubernetes_virtual_machine_infrastructure_provider.infra_moid[count.index].moid
  }


  kubernetes_version {
        object_type = var.kubevertype
        moid = data.intersight_kubernetes_version_policy.kubever_moid[count.index].moid
  }

}


#workers
resource "intersight_kubernetes_node_group_profile" "workernodegrp" {
  depends_on = [
        intersight_kubernetes_cluster_profile.kubeprof
  ]
  name = var.workergrpname
  node_type = var.workernodetype
  desiredsize = var.workerdesiredsize

  count  = 1
  ip_pools {
        object_type = var.ippooltype
        moid = data.intersight_ippool_pool.ippoolmaster_moid[count.index].moid
  }


  cluster_profile {
        object_type = var.clusterprofiletype
        # moid = intersight_kubernetes_cluster_profile.kubeprof.moid
        moid = data.intersight_kubernetes_cluster_profile.cprofile_moid[count.index].moid
  }


  infra_provider {
        object_type = var.infratype
        moid = data.intersight_kubernetes_virtual_machine_infrastructure_provider.infra_moid[count.index].moid
  }


  kubernetes_version {
        object_type = var.kubevertype
        moid = data.intersight_kubernetes_version_policy.kubever_moid[count.index].moid
  }

}


resource "intersight_kubernetes_cluster_profile" "kubeprofaction" {
  depends_on = [
        intersight_kubernetes_cluster_profile.kubeprof
  ]
  action = "Deploy"
  name = var.name 
  organization {
    object_type = "organization.Organization"
    moid        = module.intersight-moids.organization_moid
  }

}
