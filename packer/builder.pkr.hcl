build {
  sources = [
    "source.vagrant.golden-image"
  ]

  provisioner "ansible" {
    playbook_file = "playbooks/golden-image.yml"
    user          = "vagrant"
  }
}
