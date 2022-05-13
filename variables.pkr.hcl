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

# Locals

locals {
  hashed_password = bcrypt(var.password)
  user_data = templatefile("${path.root}/templatefiles/user_data.tpl",
    {
      username = var.username,
      password = local.hashed_password
  })
  meta_data = ""
}

# Amazon EBS-specific variables
variable "aws_region" {
  type    = string
  default = "us-east-1"
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

variable "aws_regions" {
  type    = list(string)
  default = ["us-east-1"]
}
