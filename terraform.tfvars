metadata = {
  serial-port-enable = 1
  ssh-keys           = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGFWU0VOTdkuWCe0B0iYaGAc5RuCNXX+bjdY5cB/vHer biparasite@Alexey.local"
}

vms_resources = {
  web={
    cores=2
    memory=2
    core_fraction=5
    hdd_size=10
    hdd_type="network-hdd"
  }
}

each_vm = [
  {
    vm_name="main",
    cpu=2,
    ram=2,
    disk_volume=10
  },
  {
    vm_name="replica",
    cpu=2,
    ram=2,
    disk_volume=10
  }
]
