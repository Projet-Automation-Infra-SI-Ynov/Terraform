terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "2.9.6"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://192.168.1.2:8006/api2/json"
  pm_user="terraform-prov@pve"
  pm_password="terraform"
}

resource "proxmox_vm_qemu" "resource-name" {
    name        = "NAME"
    target_node = "factory"
    clone = "template-debian"
    memory = 2048
    oncreate = true
    onboot = true
    network {
        bridge    = "vmbr2"
        tag = 10
        firewall  = false
        link_down = false
        model     = "virtio"
    }
    disk {
    type = "virtio"
    storage = "DATA"
    size = "32G"
  }
}