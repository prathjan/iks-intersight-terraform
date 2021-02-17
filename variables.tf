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
  type = string 
}

# ippool params

variable "ippooltype" {
  type = string 
}

variable "ippool_list" {
  type = list
}

variable "netcfg_list" {
  type = list
}
variable "syscfg_list" {
  type = list
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
variable "mgmtcfgobjtype" {
  type = string 
}
variable "mgmtcfgetcd" {
  type = bool 
}
variable "netcfgobjtype" {
  type = string 
}
variable "syscfgobjtype" {
  type = string 
}



variable "cprofile_list" {
  type = list
}
variable "infra_list" {
  type = list
}
variable "ippoolmaster_list" {
  type = list
}
variable "ippoolworker_list" {
  type = list
}
variable "kubever_list" {
  type = list
}



variable "mastergrpname" {
  type = string 
}
variable "masternodetype" {
  type = string 
}
variable "masterdesiredsize" {
  type = number 
}




variable "workergrpname" {
  type = string 
}
variable "workernodetype" {
  type = string 
}
variable "workerdesiredsize" {
  type = number 
}



variable "clusterprofiletype" {
  type = string 
}
variable "infratype" {
  type = string 
}
variable "kubevertype" {
  type = string 
}
























