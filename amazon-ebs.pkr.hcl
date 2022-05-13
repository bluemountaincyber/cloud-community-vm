source "amazon-ebs" "this" {
  region        = var.aws_region
  instance_type = var.aws_instance_type
  ssh_username  = var.username
  ssh_password  = var.password
  user_data     = local.user_data
  ami_groups    = ["all"]
  ami_name      = var.vmname
  ami_regions   = var.aws_regions
  launch_block_device_mappings {
    delete_on_termination = true
    device_name           = "/dev/sda1"
    volume_size           = var.disk_size
    volume_type           = "gp2"
  }
  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = var.aws_ami_source_filter_name
      root-device-type    = "ebs"
    }
    owners      = var.aws_ami_source_owner
    most_recent = true
  }
  force_deregister = true
  skip_create_ami = true
}