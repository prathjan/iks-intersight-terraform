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

data "intersight_organization_organization" "organization_moid" {
  name = var.organization_name
}

output "organization_moid" {
  value = data.intersight_organization_organization.organization_moid.moid
}

# Organization and other required Managed Object IDs (moids)
#module "intersight-moids" {
#  source            = "../intersight-moids"
#  organization_name = var.organization_name
#}

# IPPool moids
data "intersight_ippool_pool" "ippool_moid" {
  name  = var.ippool_list
}

# Netcfg moids
data "intersight_kubernetes_network_policy" "netcfg_moid" {
  name  = var.netcfg_list
#  moid = ""
}

# Sysconfig moids
data "intersight_kubernetes_sys_config_policy" "syscfg_moid" {
  name  = var.syscfg_list
#  moid = ""
}



# kube cluster profiles
resource "intersight_kubernetes_cluster_profile" "kubeprof" {
  name = var.name 
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization_moid.moid
  }
  cluster_ip_pools {
	object_type = "ippool.Pool" 
	moid = data.intersight_ippool_pool.ippool_moid.moid
  }
  management_config {
	encrypted_etcd = var.mgmtcfgetcd
	load_balancer_count = var.mgmtcfglbcnt
	ssh_keys = [ 
		 var.mgmtcfgsshkeys
	]
	ssh_user = var.mgmtcfgsshuser
	object_type = "kubernetes.ClusterManagementConfig" 
  }
  net_config {
	moid = data.intersight_kubernetes_network_policy.netcfg_moid.moid
	object_type = "kubernetes.NetworkPolicy" 
  }

  sys_config {
	moid = data.intersight_kubernetes_sys_config_policy.syscfg_moid.moid
	object_type = "kubernetes.SysConfigPolicy" 
  }
}


# Infra provider moids
data "intersight_kubernetes_virtual_machine_infrastructure_provider" "infra_moid" {
  name  = var.infra_list
  moid = ""
}

# IpPool moids
data "intersight_ippool_pool" "ippoolmaster_moid" {
  name  = var.ippoolmaster_list
  moid = ""
}

# IpPool moids
data "intersight_ippool_pool" "ippoolworker_moid" {
  name  = var.ippoolworker_list
  moid = ""
}

# Kube version moids
data "intersight_kubernetes_version_policy" "kubever_moid" {
  name  = var.kubever_list
  moid = ""
}


# Master
resource "intersight_kubernetes_node_group_profile" "masternodegrp" {
  name = var.mastergrpname
  node_type = "Master"
  desiredsize = var.masterdesiredsize

  ip_pools {
        object_type = "ippool.Pool" 
        moid = data.intersight_ippool_pool.ippoolmaster_moid.moid
  }


  cluster_profile {
        object_type = "kubernetes.ClusterProfile" 
        moid = intersight_kubernetes_cluster_profile.kubeprof.moid
  }

  infra_provider {
        object_type = "kubernetes.VirtualMachineInfrastructureProvider" 
        moid = data.intersight_kubernetes_virtual_machine_infrastructure_provider.infra_moid.moid
  }


  kubernetes_version {
        object_type = "kubernetes.VersionPolicy" 
        moid = data.intersight_kubernetes_version_policy.kubever_moid.moid
  }

}

#workers
resource "intersight_kubernetes_node_group_profile" "workernodegrp" {
  name = var.workergrpname
  node_type = "Worker"
  desiredsize = var.workerdesiredsize

  ip_pools {
        object_type = "ippool.Pool"
        moid = data.intersight_ippool_pool.ippoolmaster_moid.moid
  }


  cluster_profile {
        object_type = "kubernetes.ClusterProfile"
        moid = intersight_kubernetes_cluster_profile.kubeprof.moid
  }

  infra_provider {
        object_type = "kubernetes.VirtualMachineInfrastructureProvider"
        moid = data.intersight_kubernetes_virtual_machine_infrastructure_provider.infra_moid.moid
  }


  kubernetes_version {
        object_type = "kubernetes.VersionPolicy"
        moid = data.intersight_kubernetes_version_policy.kubever_moid.moid
  }
}


resource "intersight_kubernetes_cluster_profile" "kubeprofaction" {
  depends_on = [
        intersight_kubernetes_node_group_profile.workernodegrp
  ]
  action = "Deploy"
  name = intersight_kubernetes_cluster_profile.kubeprof.name
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization_moid.moid 
  }

}

