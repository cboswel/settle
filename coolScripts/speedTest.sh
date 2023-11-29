#!/bin/bash

speed=1600

rm speedResults
rm channel1
rm channel2
rm channel3
rm channel4

taskset 0xF0000000 ip netns exec ns1 ./packETHcli -xi enp193s0f1 -m 9 >> channel1 &
taskset 0x0F000000 ip netns exec ns1 ./packETHcli -q 8 -w 1q2w3e4r -o 2 -i enp193s0f1 -m 9 >> channel2 &
taskset 0x00F00000 ip netns exec ns1 ./packETHcli -q 8 -w 0o9i8u7y -o 2 -i enp193s0f1 -m 9 >> channel3 &
taskset 0x000F0000 ip netns exec ns1 ./packETHcli -q 8 -w zaqwsxcd -o 2 -i enp193s0f1 -m 9 >> channel4 &

taskset 0x0000F000 ./packETHcli -m 2 -t 40 -B $speed -i enp193s0f0 -x -f 200int32new.pcap &
taskset 0x00000F00 ./packETHcli -m 2 -t 40 -B $speed -i enp193s0f0 -q 8 -w 1q2w3e4r -o 2 -f 200int32new.pcap &
taskset 0x000000F0 ./packETHcli -m 2 -t 40 -B $speed -i enp193s0f0 -q 8 -w 0o9i8u7y -o 2 -f 200int32new.pcap &
taskset 0x0000000F ./packETHcli -m 2 -t 40 -B $speed -i enp193s0f0 -q 8 -w zaqwsxcd -o 2 -f 200int32new.pcap &

sleep 42
killall packETHcli
wait


last=$(head -n -2 channel1 | tail -n 1)

readarray -d \; -t strarr <<< ${last}
line=${strarr[2]}

read -ra strarr <<<"$line"

echo "speed is ${strarr[4]} ${strarr[5]}"
div1=$(echo "scale = 5; 100 * ${strarr[9]} / ${strarr[7]}" | bc)
echo "error rate is $div1 percent"

last=$(head -n -2 channel2 | tail -n 1)

readarray -d \; -t strarr <<< ${last}
line=${strarr[2]}

read -ra strarr <<<"$line"

echo "speed is ${strarr[4]} ${strarr[5]}"
div2=$(echo "scale = 5; 100 * ${strarr[9]} / ${strarr[7]}" | bc)
echo "error rate is $div2 percent"

last=$(head -n -2 channel3 | tail -n 1)

readarray -d \; -t strarr <<< ${last}
line=${strarr[2]}

read -ra strarr <<<"$line"

echo "speed is ${strarr[4]} ${strarr[5]}"
div3=$(echo "scale = 5; 100 * ${strarr[9]} / ${strarr[7]}" | bc)
echo "error rate is $div3 percent"

last=$(head -n -2 channel4 | tail -n 1)

readarray -d \; -t strarr <<< ${last}
line=${strarr[2]}

read -ra strarr <<<"$line"

echo "speed is ${strarr[4]} ${strarr[5]}"
div4=$(echo "scale = 5; 100 * ${strarr[9]} / ${strarr[7]}" | bc)
echo "error rate is $div4 percent"


av=$(echo "scale = 5; ($div1 + $div2 + $div3 + $div4) / 4" | bc)
echo "average error rate is $av"

#for (( n=0; n < ${#strarr[*]}; n++ ))
#do
#	        echo "${strarr[n]}"
#	done


