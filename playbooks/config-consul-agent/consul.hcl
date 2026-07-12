datacenter = "dc1"
data_dir = "/opt/consul"

bind_addr = "0.0.0.0"
client_addr = "0.0.0.0"

advertise_addr = "{{ GetInterfaceIP \"enp39s0\" }}"
retry_join = ["provider=aws tag_key=consul-key tag_value=consul-value"]
