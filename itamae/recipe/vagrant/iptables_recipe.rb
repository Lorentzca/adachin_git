execute "iptables off" do
  user "root"
  command "/etc/init.d/iptables stop;chkconfig iptables off"
end
