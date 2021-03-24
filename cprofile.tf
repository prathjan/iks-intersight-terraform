# Intersight Provider Information 
terraform {
  required_providers {
    intersight = {
      source = "CiscoDevNet/intersight"
      version = "1.0.3"
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
  value = data.intersight_organization_organization.organization_moid.results.0.moid
}


# IPPool moids
data "intersight_ippool_pool" "ippool_moid" {
  name  = var.ippool_list
}

# Netcfg moids
data "intersight_kubernetes_network_policy" "netcfg_moid" {
  name  = var.netcfg_list
}

# Sysconfig moids
data "intersight_kubernetes_sys_config_policy" "syscfg_moid" {
  name  = var.syscfg_list
}


# kube cluster profiles
resource "intersight_kubernetes_cluster_profile" "kubeprof" {
  name = var.name 
  wait_for_completion=false
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization_moid.results.0.moid
  }
  cluster_ip_pools {
	object_type = "ippool.Pool" 
	moid = data.intersight_ippool_pool.ippool_moid.results.0.moid
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
	moid = data.intersight_kubernetes_network_policy.netcfg_moid.results.0.moid
	object_type = "kubernetes.NetworkPolicy" 
  }

  sys_config {
	moid = data.intersight_kubernetes_sys_config_policy.syscfg_moid.results.0.moid
	object_type = "kubernetes.SysConfigPolicy" 
  }
}


# Infra provider moids
data "intersight_kubernetes_virtual_machine_infrastructure_provider" "infra_moid" {
  name  = var.infra_list
}

# IpPool moids
data "intersight_ippool_pool" "ippoolmaster_moid" {
  name  = var.ippoolmaster_list
}

# IpPool moids
data "intersight_ippool_pool" "ippoolworker_moid" {
  name  = var.ippoolworker_list
}

# Kube version moids
data "intersight_kubernetes_version_policy" "kubever_moid" {
  name  = var.kubever_list
}


# Master
resource "intersight_kubernetes_node_group_profile" "masternodegrp" {
  name = var.mastergrpname
  node_type = "Master"
  desiredsize = var.masterdesiredsize

  ip_pools {
        object_type = "ippool.Pool" 
        moid = data.intersight_ippool_pool.ippoolmaster_moid.results.0.moid
  }


  cluster_profile {
        object_type = "kubernetes.ClusterProfile" 
        moid = intersight_kubernetes_cluster_profile.kubeprof.moid
  }

  infra_provider {
        object_type = "kubernetes.VirtualMachineInfrastructureProvider" 
        moid = data.intersight_kubernetes_virtual_machine_infrastructure_provider.infra_moid.results.0.moid
  }


  kubernetes_version {
        object_type = "kubernetes.VersionPolicy" 
        moid = data.intersight_kubernetes_version_policy.kubever_moid.results.0.moid
  }

}

#workers
#resource "intersight_kubernetes_node_group_profile" "workernodegrp" {
#  name = var.workergrpname
#  node_type = "Worker"
#  desiredsize = var.workerdesiredsize
#
#  ip_pools {
#        object_type = "ippool.Pool"
#        moid = data.intersight_ippool_pool.ippoolmaster_moid.results.0.moid
#  }
#
#
#  cluster_profile {
#        object_type = "kubernetes.ClusterProfile"
#        moid = intersight_kubernetes_cluster_profile.kubeprof.moid
#  }
#
#  infra_provider {
#        object_type = "kubernetes.VirtualMachineInfrastructureProvider"
#        moid = data.intersight_kubernetes_virtual_machine_infrastructure_provider.infra_moid.results.0.moid
#  }
#
#
#  kubernetes_version {
#        object_type = "kubernetes.VersionPolicy"
#        moid = data.intersight_kubernetes_version_policy.kubever_moid.results.0.moid
#  }
#}

resource "intersight_kubernetes_cluster_profile" "kubeprofaction" {
  depends_on = [
        intersight_kubernetes_node_group_profile.masternodegrp
        #intersight_kubernetes_node_group_profile.workernodegrp
  ]
  action = "Deploy"
  name = intersight_kubernetes_cluster_profile.kubeprof.name
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization_moid.results.0.moid 
  }

}

#Wait for cluster to come up and then outpt the kubeconfig, if successful
output "kube_config" {
	value = intersight_kubernetes_cluster_profile.kubeprofaction.kube_config[0].kube_config
}
