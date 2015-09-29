#nginx
package 'http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm' do
  not_if 'rpm -q nginx-release-centos-6-0.el6.ngx.noarch'
end

package "nginx" do
  action :install
end

#apache
package "httpd" do
end

HTTPD00 = "httpd-00.conf"

directory "/etc/httpd/conf.d.local" do
end

file "/etc/httpd/conf.d.local/#{HTTPD00}" do
end

template "/etc/httpd/conf.d.local/#{HTTPD00}" do
  owner "root"
  source "~/httpd_template/#{HTTPD00}.erb"
    variables(goodbye: "Good bye")
  end
