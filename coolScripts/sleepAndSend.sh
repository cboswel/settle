#!/bin/bash

sleep 10
sudo ip netns exec ns1 ./packETHcli -m 2 -t 40 -B 4500 -i enp193s0f1 -f 200int32.pcap &
