#!/bin/bash

unit=mbit

if [ $# -eq 0 ]
  then
    echo "Usage: ./network_setup.sh [<ip> <limit_in_mb>]"
    exit 1
fi

sudo tc qdisc del dev eth2 root
sudo tc qdisc del dev eth2 ingress
sudo tc class del dev eth2 root
sudo tc filter del dev eth2 root


num_rules=$(( $# / 2 ))
echo "Adding $num_rules new rules"

sudo tc qdisc add dev eth2 root handle 1: htb default 12
sudo tc class add dev eth2 parent 1: classid 1:12 htb rate 10000mbit ceil 10000mbit

for i in $(seq 1 $num_rules); do
	echo "Adding rule $i"
        bw=$(( $i * 2 ))
	ip=$(( $bw - 1 ))

	echo "Params $ip $bw"       
 	
	echo "sudo tc class add dev eth2 parent 1: classid 1:$i htb rate ${!bw}$unit ceil ${!bw}$unit"
	sudo tc class add dev eth2 parent 1: classid 1:$i htb rate ${!bw}$unit ceil ${!bw}$unit
	#sudo tc qdisc add dev eth2 parent 1:$i handle $i: netem delay 10ms 5ms 25% distribution normal
	echo "sudo tc filter add dev eth2 protocol ip parent 1:0 prio 1 u32 match ip dst ${!ip}/32 flowid 1:$i"
	sudo tc filter add dev eth2 protocol ip parent 1:0 prio 5 u32 match ip dst ${!ip}/32 flowid 1:$i


	sudo tc class add dev eth2 parent 1: classid 1:9$i htb rate 10000mbit ceil 10000mbit
	sudo tc filter add dev eth2 protocol ip parent 1:0 prio 2 u32 match ip sport 9092 0xffff flowid 1:9$i
	sudo tc filter add dev eth2 protocol ip parent 1:0 prio 2 u32 match ip sport 9093 0xffff flowid 1:9$i
	sudo tc filter add dev eth2 protocol ip parent 1:0 prio 2 u32 match ip sport 9094 0xffff flowid 1:9$i
	sudo tc filter add dev eth2 protocol ip parent 1:0 prio 2 u32 match ip sport 9095 0xffff flowid 1:9$i
	sudo tc filter add dev eth2 protocol ip parent 1:0 prio 2 u32 match ip dport 9092 0xffff flowid 1:9$i
	sudo tc filter add dev eth2 protocol ip parent 1:0 prio 2 u32 match ip dport 9093 0xffff flowid 1:9$i
	sudo tc filter add dev eth2 protocol ip parent 1:0 prio 2 u32 match ip dport 9094 0xffff flowid 1:9$i
	sudo tc filter add dev eth2 protocol ip parent 1:0 prio 2 u32 match ip dport 9095 0xffff flowid 1:9$i
	sudo tc filter add dev eth2 protocol ip parent 1:0 prio 2 u32 match ip dport 6668 0xffff flowid 1:9$i

	sudo tc filter add dev eth2 protocol ip parent 1:0 prio 2 u32 match ip sport 8080 0xffff flowid 1:9$i
	sudo tc filter add dev eth2 protocol ip parent 1:0 prio 2 u32 match ip dport 8080 0xffff flowid 1:9$i
done

