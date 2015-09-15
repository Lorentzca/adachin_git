package 'http://ftp-srv2.kddilabs.jp/Linux/distributions/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm' do
  not_if 'rpm -q epel-release-6-8.noarch.rpm '
end

package "htop" do
  action :install
end
