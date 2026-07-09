datacenter = "dc1"
data_dir = "/opt/consul"

bind_addr = "0.0.0.0"
client_addr = "0.0.0.0"
log_level  = "INFO"

advertise_addr = "{{ GetInterfaceIP}}"
retry_join = ["10.5.11.223"]
