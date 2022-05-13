build {
  sources = ["amazon-ebs.this", "azure-arm.this", "googlecompute.this", "vmware-iso.this"]

  provisioner "shell" {
    inline = [
      "sudo apt update",
      "sudo apt install software-properties-common",
      "sudo add-apt-repository --yes --update ppa:ansible/ansible",
      "sudo apt install ansible -y"
    ]
  }

  provisioner "ansible-local" {
    playbook_file = "${path.root}/ansible/playbook.yml"
  }
}