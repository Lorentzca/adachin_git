#!/bin/sh
#実行したコマンドがどのくらいかかったのか

 for x in `seq 1 5`; do
echo -n "start server"$x":" 
echo `date "+%Y%m%d_%H%M%S"`

rsync -av hoge server$x::hoge /hoge
echo -n "end server"$x":" 

echo `date "+%Y%m%d_%H%M%S"`
 done


#cron

00,30 1-23 * * * /usr/bin/setlock -nx /tmp/rsync.lock /hoge/bin/time_rsync.sh > /var/tmp/rsync_server_`date +'\%Y\
%m\%d\%H\%M'`
