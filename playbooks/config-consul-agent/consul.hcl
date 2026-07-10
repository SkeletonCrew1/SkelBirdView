datacenter = "dc1"
data_dir = "/opt/consul"

bind_addr = "0.0.0.0"
client_addr = "0.0.0.0"
log_level  = "INFO"

advertise_addr = "{{ GetInterfaceIP \"en0\" }}"
retry_join = ["provider=aws tag_key=consul-key tag_value=consul-server"]
