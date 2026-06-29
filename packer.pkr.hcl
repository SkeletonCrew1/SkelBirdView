packer {
  required_plugins {
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = ">= 1.1.7"
    }

    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = ">= 1.1.5"
    }
  }
}

source "vagrant" "golden-image" {
  communicator = "ssh"
  source_path  = "bento/ubuntu-26.04"
  provider     = "virtualbox"
  add_force    = true
}

build {
  sources = [
    "source.vagrant.golden-image"
  ]

  provisioner "ansible" {
    playbook_file = "ansible/golden-image-playbook.yml"
    user          = "vagrant"
  }
}
