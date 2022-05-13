source "googlecompute" "this" {
  account_file = var.gcp_service_account_credentials_file
  project_id = var.gcp_project_id
  zone = var.gcp_availability_zone
  disk_size = var.disk_size
  machine_type = var.gcp_machine_type
  source_image_family = var.gcp_source_image_family
  ssh_username = var.username
  ssh_password = var.password
  metadata = {
    startup-script = local.user_data
  }
}