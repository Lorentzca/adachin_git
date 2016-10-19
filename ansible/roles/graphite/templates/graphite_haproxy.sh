# haproxy monitor
#
# https://github.com/vigne/HAP-Monitor
# https://www.datadoghq.com/blog/monitoring-haproxy-performance-metrics/

/usr/local/bin/hap-monitor-cron.py --socket /var/lib/haproxy/stats1 --backend {{ graphite_host }}:2003::carbon.adachin.{{ inventory_hostname }}.haproxy --type g 1>/dev/null
