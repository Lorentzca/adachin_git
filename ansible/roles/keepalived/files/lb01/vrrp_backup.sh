#!/bin/sh
/bin/echo 0 > /proc/sys/net/ipv4/conf/eth1/proxy_arp

IPLST="/etc/keepalived/ip_list.txt"

for ip in `cat $IPLST` ; do
  /sbin/ip route del $ip dev eth0
done
