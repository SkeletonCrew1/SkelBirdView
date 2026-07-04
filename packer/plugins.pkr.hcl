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
