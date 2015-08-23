
#---------------------
# package
#---------------------

# Apacheをインスコ
#  sudo yum install -y httpd
package "httpd" do
    action :install
end

# MySQLをインスコ
#  sudo yum install -y mysql-server
package "mysql-server" do
    action :install
end

# PHPと関連するモジュールをインスコ
#  sudo yum install -y php
#  sudo yum install -y php-mbstring
#  sudo yum install -y php-mysql
package "php" do
    action :install
end
package "php-mbstring" do
    action :install
end
package "php-mysql" do
    action :install
end


#--------------------------------------
# service
#--------------------------------------

# Apacheの起動と自動起動の設定
#  sudo service httpd start
#  sudo chkconfig on
service "httpd" do
  action [:start, :enable]
end

# MySQLの起動と自動起動の設定
#  sudo service mysqld start
#  sudo chkconfig mysqld on
service 'mysqld' do
  action [:start, :enable]
end
