source "azure-arm" "this" {
  image_publisher = var.azure_image_publisher
  image_offer = var.azure_image_offer
  image_sku = var.azure_image_sku
  image_version = var.azure_image_version
  location = var.azure_location
  managed_image_zone_resilient = true
  managed_image_name = var.vmname
  vm_size = var.azure_vm_size
  os_type = "Linux"

  ssh_username = var.username
  ssh_password = var.password

  managed_image_resource_group_name = var.azure_resource_group_name
  tenant_id = var.azure_tenant_id
  subscription_id = var.azure_subscription_id
  client_id = var.azure_client_id
  client_secret = var.azure_client_secret
}