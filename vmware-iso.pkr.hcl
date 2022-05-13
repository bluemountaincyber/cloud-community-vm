source "vmware-iso" "this" {
  vm_name = var.vmname
  guest_os_type = "ubuntu-64"
  output_directory = "${path.root}/vmware-iso"

  boot_command     = local.vmware_boot_command
  boot_wait        = "6s"
  shutdown_command = local.vmware_shutdown_command

  disk_size = convert("${var.disk_size}000", number)
  disk_type_id = "0"
  cpus         = var.vmware_cpus
  memory       = var.vmware_memory

  iso_urls = local.vmware_iso_urls
  iso_checksum = local.vmware_iso_checksum

  ssh_username     = var.username
  ssh_password     = var.password
  ssh_pty          = false
  ssh_wait_timeout = "10000s"

  http_content = {
    "/user-data" = local.vmware_user_data
    "/meta-data" = local.vmware_meta_data
  }
}