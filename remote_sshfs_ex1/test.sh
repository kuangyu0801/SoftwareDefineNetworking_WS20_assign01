#!/bin/sh
# Deletes all flow entries
curl http://localhost:8080/wm/staticentrypusher/clear/all/json

# flood arp request
# h1
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:01", "name":"host1-flood-arp", "cookie":"0", "priority":"2","eth_type":"0x0806", "in_port":"2", "active":"true", "instruction_apply_actions":"output=flood"}' http://localhost:8080/wm/staticentrypusher/json
# flooding
# S1 receives arp request from H2
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:01", "name":"s1-rcv-h2-arp-request", "cookie":"0", "priority":"2","eth_type":"0x0806", "in_port":"3", "active":"true", "instruction_apply_actions":"push_vlan=0x8100,set_field=eth_vlan_vid->1,output=flood"}' http://localhost:8080/wm/staticentrypusher/json
# S2 receives arp request from S1
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:02", "name":"s2-rcv-s1-arp-request", "cookie":"0", "priority":"2","eth_type":"0x0806", "in_port":"1", "eth_vlan_vid":"0x1001", "active":"true", "instruction_apply_actions":"pop_vlan,output=flood"}' http://localhost:8080/wm/staticentrypusher/json
# S2 receives arp request from H3
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:02", "name":"s2-rcv-h3-arp-request", "cookie":"0", "priority":"2","eth_type":"0x0806", "in_port":"3", "active":"true", "instruction_apply_actions":"push_vlan=0x8100,set_field=eth_vlan_vid->1,output=flood"}' http://localhost:8080/wm/staticentrypusher/json
# S2 receives arp request from H3
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:02", "name":"s2-rcv-h4-arp-request", "cookie":"0", "priority":"2","eth_type":"0x0806", "in_port":"2", "active":"true", "instruction_apply_actions":"push_vlan=0x8100,set_field=eth_vlan_vid->1,output=flood"}' http://localhost:8080/wm/staticentrypusher/json
# S1 receives arp request from S2
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:01", "name":"s1-rcv-s2-arp-request", "cookie":"0", "priority":"2","eth_type":"0x0806", "in_port":"1", "eth_vlan_vid":"0x1001", "active":"true", "instruction_apply_actions":"pop_vlan,output=3"}' http://localhost:8080/wm/staticentrypusher/json

# arp-echo
# S1 receives h2 arp-echo for h3
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:01", "name":"s1-rcv-h2-arp-echo-h3", "cookie":"0", "priority":"2","eth_type":"0x0806", "in_port":"3", "arp_tha":"00:00:00:00:00:03", "active":"true", "instruction_apply_actions":"push_vlan=0x8100,set_field=eth_vlan_vid->1,output=1"}' http://localhost:8080/wm/staticentrypusher/json
# S1 receives h2 arp-echo for h4
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:01", "name":"s1-rcv-h2-arp-echo-h4", "cookie":"0", "priority":"2","eth_type":"0x0806", "in_port":"3", "arp_tha":"00:00:00:00:00:04", "active":"true", "instruction_apply_actions":"pop_vlan,output=3"}' http://localhost:8080/wm/staticentrypusher/json
# S2 receives h2 arp-echo for h3 via S2
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:02", "name":"s2-rcv-h2-arp-echo-h3", "cookie":"0", "priority":"2","eth_type":"0x0806", "in_port":"1", "arp_tha":"00:00:00:00:00:03", "eth_vlan_vid":"0x1001", "active":"true", "instruction_apply_actions":"pop_vlan,output=3"}' http://localhost:8080/wm/staticentrypusher/json
# S2 receives h2 arp-echo for h4 via S2
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:02", "name":"s2-rcv-h2-arp-echo-h4", "cookie":"0", "priority":"2","eth_type":"0x0806", "in_port":"1", "arp_tha":"00:00:00:00:00:04", "eth_vlan_vid":"0x1001", "active":"true", "instruction_apply_actions":"pop_vlan,output=2"}' http://localhost:8080/wm/staticentrypusher/json
