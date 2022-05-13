#cloud-config
system_info:
  default_user:
    name: ${username}
    homedir: /home/${username}
    primary_group: ${username}
    group: sudo
    sudo: ALL=(ALL) NOPASSWD:ALL
    lock_passwd: false
    shell: /bin/bash
    passwd: ${password}
ssh_pwauth: true
