datacenter = "dc1"
data_dir = "/opt/consul"

bind_addr = "0.0.0.0"
client_addr = "0.0.0.0"
log_level  = "INFO"

advertise_addr = "{{ GetInterfaceIP `eth1` }}"

bootstrap_expect = 1
server = true
ui = true

