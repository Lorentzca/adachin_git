#!/bin/sh
#実行したコマンドがどのくらいかかったのか

 for x in `seq 1 5`; do
echo -n "start server"$x":" 
echo `date "+%Y%m%d_%H%M%S"`

rsync -av hoge server$x::hoge /hoge
echo -n "end server"$x":" 

echo `date "+%Y%m%d_%H%M%S"`
 done
