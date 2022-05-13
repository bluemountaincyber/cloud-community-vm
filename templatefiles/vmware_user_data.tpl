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
