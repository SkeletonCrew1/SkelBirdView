source "vagrant" "golden-image" {
  communicator = "ssh"
  source_path  = "bento/ubuntu-26.04"
  provider     = "virtualbox"
  add_force    = true
}
