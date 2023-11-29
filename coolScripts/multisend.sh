#!/bin/bash
./packETHcli -m 2 -B 2000 -n 0 -i enp193s0f0 -x -f 200int32.pcap &
./packETHcli -m 2 -B 2000 -n 0 -i enp193s0f0 -x -f 200int32.pcap &
./packETHcli -m 2 -B 2000 -n 0 -i enp193s0f0 -x -f 200int32.pcap &
ip netns exec ns1 ./packETHcli -xi enp193s0f1 -m 9
