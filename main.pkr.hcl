build {
  sources = ["amazon-ebs.this"]

  provisioner "shell" {
    inline = [
      "sudo apt update",
      "sudo apt install ansible -y"
    ]
  }

  provisioner "ansible-local" {
    playbook_file = "${path.root}/ansible/playbook.yml"
  }
}