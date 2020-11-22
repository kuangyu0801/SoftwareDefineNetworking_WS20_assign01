#!/bin/sh
# Deletes all flow entries
curl http://localhost:8080/wm/staticentrypusher/clear/all/json

# flood arp request

# IP forwarding
# S1
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:01", "name":"s1-src-h2-dst-h3","eth_type":"0x0800", "eth_src":"00:00:00:00:00:02", "eth_dst":"00:00:00:00:00:03", "active":"true", "actions":"output=1"}' http://localhost:8080/wm/staticentrypusher/json
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:01", "name":"s1-src-h2-dst-h4","eth_type":"0x0800", "eth_src":"00:00:00:00:00:02", "eth_dst":"00:00:00:00:00:04", "active":"true", "actions":"output=1"}' http://localhost:8080/wm/staticentrypusher/json
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:01", "name":"s1-src-h3-dst-h2","eth_type":"0x0800", "eth_src":"00:00:00:00:00:03", "eth_dst":"00:00:00:00:00:02", "active":"true", "actions":"output=3"}' http://localhost:8080/wm/staticentrypusher/json
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:01", "name":"s1-src-h4-dst-h2","eth_type":"0x0800", "eth_src":"00:00:00:00:00:04", "eth_dst":"00:00:00:00:00:02", "active":"true", "actions":"output=3"}' http://localhost:8080/wm/staticentrypusher/json

# S2
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:02", "name":"s2-src-h2-dst-h3", "eth_src":"00:00:00:00:00:02", "eth_dst":"00:00:00:00:00:03", "active":"true", "actions":"output=3"}' http://localhost:8080/wm/staticentrypusher/json
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:02", "name":"s2-src-h2-dst-h4", "eth_src":"00:00:00:00:00:02", "eth_dst":"00:00:00:00:00:04", "active":"true", "actions":"output=2"}' http://localhost:8080/wm/staticentrypusher/json
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:02", "name":"s2-src-h3-dst-h2", "eth_src":"00:00:00:00:00:03", "eth_dst":"00:00:00:00:00:02", "active":"true", "actions":"output=1"}' http://localhost:8080/wm/staticentrypusher/json
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:02", "name":"s2-src-h4-dst-h2", "eth_src":"00:00:00:00:00:04", "eth_dst":"00:00:00:00:00:02", "active":"true", "actions":"output=1"}' http://localhost:8080/wm/staticentrypusher/json


# ARP forwarding

curl -X POST -d '{"switch":"00:00:00:00:00:00:00:01", "name":"arp-s1-src-h2", "eth_type":"0x0806", "arp_sha":"00:00:00:00:00:02", "active":"true", "actions":"output=1"}' http://localhost:8080/wm/staticentrypusher/json
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:01", "name":"arp-s1-src-h3", "eth_type":"0x0806", "arp_sha":"00:00:00:00:00:03", "active":"true", "actions":"output=3"}' http://localhost:8080/wm/staticentrypusher/json
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:01", "name":"arp-s1-src-h4", "eth_type":"0x0806", "arp_sha":"00:00:00:00:00:04", "active":"true", "actions":"output=3"}' http://localhost:8080/wm/staticentrypusher/json

# S2
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:02", "name":"arp-s2-src-h2-dst-h3", "eth_type":"0x0806", "arp_sha":"00:00:00:00:00:02", "active":"true", "actions":"output=3,output=2"}' http://localhost:8080/wm/staticentrypusher/json
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:02", "name":"arp-s2-src-h3-dst-h2", "eth_type":"0x0806", "arp_sha":"00:00:00:00:00:03", "active":"true", "actions":"output=1,output=2"}' http://localhost:8080/wm/staticentrypusher/json
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:02", "name":"arp-s2-src-h4-dst-h2", "eth_type":"0x0806", "arp_sha":"00:00:00:00:00:04", "active":"true", "actions":"output=1,output=3"}' http://localhost:8080/wm/staticentrypusher/json
