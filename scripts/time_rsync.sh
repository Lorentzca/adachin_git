#!/bin/sh
#rsync_timescripts
#実行したコマンドがどのくらいなのか

echo "time" 

  time -p {
    rsync -a --rsync-path="ionice -c2 -n7 nice -n19 rsync" /hoge /newhoge
  }
done
