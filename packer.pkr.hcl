packer {
  required_plugins {
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = ">= 1.0.0"
    }

    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = ">= 1.1.4"
    }
  }
}

source "vagrant" "golden-image" {
  communicator = "ssh"
  source_path  = "bento/ubuntu-26.04"
  provider     = "virtualbox"
  skip_add     = true
}

build {
  sources = [
    "source.vagrant.golden-image"
  ]

  provisioner "ansible" {
    playbook_file = "ansible/golden-image-playbook.yml"
  }
}
