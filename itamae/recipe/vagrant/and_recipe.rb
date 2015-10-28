execute "ant download" do
 user "root"
 command "wget http://ftp.yz.yamagata-u.ac.jp/pub/network/apache//ant/binaries/apache-ant-1.9.6-bin.tar.gz -P /var/tmp"
end

execute "tar ant" do
 user "root"
 command "tar -xzvf /var/tmp/apache-ant-1.9.6-bin.tar.gz -C /usr/tmp"
end

execute "mv ant" do
  user "root"
  command "mv /var/tmp/apache-ant-1.9.6 /usr/java"
 end


execute "ln ant" do
 user "root"
 command "ln -s /usr/java/apache-ant-1.9.6 /usr/java/ant"
end

