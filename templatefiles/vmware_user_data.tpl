#cloud-config
autoinstall:
  version: 1
  apt:
    geoip: true
    disable_components: []
    preserve_sources_list: false
    primary:
      - arches: [amd64, i386]
        uri: http://us.archive.ubuntu.com/ubuntu
      - arches: [default]
        uri: http://ports.ubuntu.com/ubuntu-ports
  early-commands:
    - sudo systemctl stop ssh
  locale: en_US
  package_update: true
  keyboard:
    layout: us
  storage:
    config:
    - grub_device: true
      id: disk-sda
      path: /dev/sda
      ptable: gpt
      type: disk
      wipe: superblock-recursive
    - device: disk-sda
      flag: bios_grub
      id: partition-0
      number: 1
      size: 1048576
      type: partition
    - device: disk-sda
      id: partition-1
      number: 2
      size: -1
      type: partition
      wipe: superblock
    - fstype: ext4
      id: format-0
      type: format
      volume: partition-1
    - device: format-0
      id: mount-0
      path: /
      type: mount
  identity:
    hostname: ${vmname}
    username: ${username}
    password: ${password}
  ssh:
    install-server: true
    allow-pw: true
  packages:
    - openssh-server
    - open-vm-tools
  user-data:
    disable_root: false
    timezone: UTC
  late-commands:
    - sed -i -e 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /target/etc/ssh/sshd_config
    - echo '${username} ALL=(ALL) NOPASSWD:ALL' > /target/etc/sudoers.d/${username}
    - curtin in-target --target=/target -- chmod 440 /etc/sudoers.d/${username}
