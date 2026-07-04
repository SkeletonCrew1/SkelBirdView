build {
  name = "golden-image-builder"

  sources = [
    "source.amazon-ebs.ubuntu26-golden-image"
  ]

  provisioner "ansible" {
    playbook_file = "playbooks/golden-image.yml"
    user          = "ubuntu"

    ansible_env_vars = [
      "datadog_api_key=${var.datadog_api_key}",
      "datadog_site=${var.datadog_site}"
    ]
  }
}
