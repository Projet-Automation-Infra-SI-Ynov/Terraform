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
    name        = "TESTIP"
    target_node = "factory"
    clone = "template-debian"
    memory = 2048
    oncreate = true
    onboot = true
    pool = "Projet-Infra"
    agent = 1
    #ipconfig0 = "ip=192.168.10.18/24,gw=192.168.10.254"
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