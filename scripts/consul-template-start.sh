#!/bin/bash

# wait until consul server will be available
until curl -s http://192.168.56.100:8500/v1/health/service/web?passing | grep -q "ServiceID"; do
  sleep 5
done

# start consul template 
sudo /usr/local/bin/consul-template \
  -consul-addr=192.168.56.100:8500 \
  -template="/etc/consul-template/load-balancer.conf.ctmpl:/etc/nginx/conf.d/loadbalancer.conf:systemctl reload nginx" \
  -once