#!/bin/sh
mycnf_path=/etc/zabbix/.zabbix_my.cnf

echo_sql() {
  cat <<'EOF'
show global status;
show engine innodb status\G
EOF
}

echo_sql | mysql --defaults-extra-file=$mycnf_path | sed -e "s/------- TRX HAS BEEN WAITING/Trx_waiting/g" | awk '
BEGIN{w_time_sum=0} {if($1=="Trx_waiting") w_time_sum += $2 } END{print "Trx_waiting", w_time_sum}
$1=="Bytes_received" { print "Bytes_received", $2 }
$1=="Bytes_sent" { print "Bytes_sent", $2 }
$1=="Com_insert" { print "Com_insert", $2 }
$1=="Com_select" { print "Com_select", $2 }
$1=="Com_update" { print "Com_update", $2 }
$1=="Com_delete" { print "Com_delete", $2 }
$1=="Threads_connected" { print "Threads_connected", $2 }
$1=="Threads_running" { print "Threads_running", $2 }
/^Buffer pool hit rate [0-9]+ \/ [0-9]+/ {
  print "Buffer_pool_hit_rate", $5 / $7
}
/^[0-9.]+ inserts\/s, [0-9.]+ updates\/s, [0-9.]+ deletes\/s, [0-9.]+ reads\/s/ {
  print "insertsPerSec", $1
  print "updatesPerSec", $3
  print "deletesPerSec", $5
  print "readsPerSec", $7
}
'
