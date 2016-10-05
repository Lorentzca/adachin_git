#!/bin/bash

name="process.count.nginx"
monitor_time=`date +%s`
count=`ps aux | grep nginx | grep -v grep | wc -l`
echo -e "${name}\t${count}\t${monitor_time}"
