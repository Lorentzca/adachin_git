package 'http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm' do
  not_if 'rpm -q mysql-community-release-el6-5'
end

package "mysql-server" do
end

package "mysql-devel" do
end

package "mysql" do
end


execute "mysql user" do
   user "root"
    command "mysql -u root -e \"CREATE USER 'adachin'@'localhost' IDENTIFIED BY 'pass';\""


