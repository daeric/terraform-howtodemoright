#cloud-config
user: nutanix
password: how2demoright! 
chpasswd: {expire: False}
sudo: ALL=(ALL) NOPASSWD:ALL
ssh_pwauth: True
fqdn: ${hostname}.local.lab
hostname: ${hostname}

apt_upgrade: true

packages:
   - python-is-python3

runcmd:
  - [mkdir, /mnt/nutanix]
  - [mount, /dev/sr1, /mnt/nutanix]
  - [python, /mnt/nutanix/installer/linux/install_ngt.py]
