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

variable "DATADOG_API_KEY" {
  type    = string
  default = env("DATADOG_API_KEY")
}

variable "DATADOG_SITE" {
  type    = string
  default = env("DATADOG_SITE")
}

build {
  sources = [
    "source.vagrant.golden-image"
  ]

  provisioner "ansible" {
    playbook_file = "playbooks/golden-image.yml"
    user          = "vagrant"

    ansible_env_vars = [
      "DATADOG_API_KEY=${var.DATADOG_API_KEY}",
      "DATADOG_SITE=${var.DATADOG_SITE}"
    ]
  }
}
