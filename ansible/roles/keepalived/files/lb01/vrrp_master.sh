#!/bin/sh
/bin/echo 1 > /proc/sys/net/ipv4/conf/eth1/proxy_arp

IPLST="/etc/keepalived/ip_list.txt"

for ip in `cat $IPLST` ; do
  /sbin/ip route add $ip dev eth0
  /bin/echo "garp -i eth1 -a $ip -n 10" | logger -t GARP
  /usr/bin/garp -i eth1 -a $ip -n 10
done

