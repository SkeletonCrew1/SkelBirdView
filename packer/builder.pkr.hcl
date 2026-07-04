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
