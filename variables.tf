# API key info
variable "api_private_key" {}

variable "api_key_id" {}

variable "api_endpoint" {
  default = "https://www.intersight.com"
}


variable "organization_name" {
  default = "default"
}

variable "name" {
  description = <<-EOT
	Name of your IKS cluster Profile
  EOT
  type = string 
}

# ippool params


variable "ippool_list" {
  type = string 
}

variable "netcfg_list" {
  type = string 
}
variable "syscfg_list" {
  type = string 
}
variable "orgobjtype" {
  type = string 
}
variable "mgmtcfgsshuser" {
  type = string 
}
variable "mgmtcfglbcnt" {
  type = number 
}
variable "mgmtcfgsshkeys" {
  type = string 
}
variable "mgmtcfgetcd" {
  type = bool 
}



variable "infra_list" {
  type = string 
}
variable "ippoolmaster_list" {
  type = string 
}
variable "ippoolworker_list" {
  type = string 
}
variable "kubever_list" {
  type = string 
}
variable "mastergrpname" {
  type = string 
}
variable "masterdesiredsize" {
  type = number 
}
variable "workergrpname" {
  type = string 
}
variable "workerdesiredsize" {
  type = number 
}

























