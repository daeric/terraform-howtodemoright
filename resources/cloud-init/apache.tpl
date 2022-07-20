#cloud-config
user: nutanix
password: how2Demoright! 
chpasswd: {expire: False}
sudo: ALL=(ALL) NOPASSWD:ALL
ssh_pwauth: True
fqdn: ${hostname}.local.lab
hostname: ${hostname}

apt_upgrade: true

packages:
  - apache2
  - python-is-python3

runcmd:
  - [mkdir, /mnt/nutanix]
  - [mount, /dev/sr1, /mnt/nutanix]
  - [python, /mnt/nutanix/installer/linux/install_ngt.py]

write_files: 
  - path: /var/www/html/index.html
    owner: root:root
    permissions: "0644"
    content: "<h1>Welcome (to the jungle)!</h1>"
