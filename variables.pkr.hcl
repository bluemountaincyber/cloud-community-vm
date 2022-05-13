# Global variables
variable "vmname" {
  type    = string
  default = "cloudsecurity"
}

variable "username" {
  type    = string
  default = "cloudsecurity"
}

variable "password" {
  type    = string
  default = "C1oud$ecurity"
}

variable "disk_size" {
  type    = number
  default = 20
}

# Amazon EBS-specific variables
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_regions" {
  type    = list(string)
  default = ["us-east-1"]
}

variable "aws_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "aws_ami_source_owner" {
  type    = list(string)
  default = ["099720109477"]
}

variable "aws_ami_source_filter_name" {
  type    = string
  default = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
}

variable "aws_ami_username" {
  type    = string
  default = "ubuntu"
}

# Azure RM-specific variables
variable "azure_location" {
  type = string
  default = "westeurope"
}

variable "azure_vm_size" {
  type = string
  default = "Standard_B1s"
}

variable "azure_image_publisher" {
  type = string
  default = "Canonical"
}

variable "azure_image_offer" {
  type = string
  default = "0001-com-ubuntu-server-focal"
}

variable "azure_image_sku" {
  type = string
  default = "20_04-lts-gen2"
}

variable "azure_image_version" {
  type = string
  default = "latest"
}

## Create resource group, application, service principal, and give rights to service principal. 
## See https://docs.microsoft.com/en-us/azure/virtual-machines/linux/build-image-with-packer 
## for details. Afterwards, fill in YOUR values here:

variable "azure_resource_group_name" {
  type = string
  default = "packer"
}

variable "azure_subscription_id" {
  type = string
  default = ""
}

variable "azure_client_id" {
  type = string
  default = ""
}

variable "azure_client_secret" {
  type = string
  default = ""
}

variable "azure_tenant_id" {
  type = string
  default = ""
}

# Google Compute-specific variables
variable "gcp_availability_zone" {
  type = string
  default = "us-central1-a"
}

variable "gcp_source_image_family" {
  type = string
  default = "ubuntu-2004-lts"
}

variable "gcp_machine_type" {
  type = string
  default = "e2-micro"
}

## Create a GCP service account, attach a role to it, and download service account .json file.
## Enter YOUR GCP project ID and path to service account .json file here:

variable "gcp_project_id" {
  type = string
  default = "sroc-testing"
}

variable "gcp_service_account_credentials_file" {
  type = string
  default = "C:\\Users\\instructor\\Downloads\\sroc-testing-3f9567c7abeb.json"
}

# VMware ISO-specific variables
variable "vmware_iso_directory" {
  type = string
  default = "https://releases.ubuntu.com/20.04"
}

variable "vmware_iso_filename" {
  type = string
  default = "ubuntu-20.04.4-live-server-amd64.iso"
}

variable "vmware_cpus" {
  type = number
  default = 2
}

variable "vmware_memory" {
  type = number
  default = 4096
}

# Locals
locals {
  hashed_password = bcrypt(var.password)
  user_data = templatefile("${path.root}/templatefiles/user_data.tpl",
    {
      username = var.username,
      password = local.hashed_password
  })
  meta_data = ""
  azure_storage_account_name = formatdate("%s", timestamp())
  vmware_iso_checksum = "file:${var.vmware_iso_directory}/SHA256SUMS"
  vmware_iso_urls = ["${var.vmware_iso_directory}/${var.vmware_iso_filename}"]
  vmware_meta_data = templatefile("${path.root}/templatefiles/vmware_meta_data.tpl",
  {
    content = ""
  })
  vmware_user_data = templatefile("${path.root}/templatefiles/vmware_user_data.tpl",
  {
    vmname = var.vmname
    username = var.username
    password = bcrypt(var.password)
  })
  vmware_boot_command = [
    "<esc><esc><esc>",
    "<enter><wait>",
    "/casper/vmlinuz ",
    "root=/dev/sr0 ",
    "initrd=/casper/initrd ",
    "autoinstall ",
    "ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
    "<enter>"
  ]
  vmware_shutdown_command = "echo '${var.password}' | sudo -S shutdown -P now"
}
