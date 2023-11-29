#!/bin/bash

netns=ns1
dev2=enp193s0f1

ip netns add "$netns"
ip link set dev "$dev2" down
ip link set dev "$dev2" netns "$netns"
ip netns exec "$netns" ip address add 192.168.0.2/24 dev "$dev2"
ip netns exec "$netns" ip link set dev "$dev2" up
cowsay "pinging..."
ping 192.168.0.2
