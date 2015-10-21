package "git" do
  action :install
end

package "gcc" do
  action :install
end

package "openssl-devel" do
  action :install
end

package "readline-devel" do
  action :install
end

package "zlib-devel" do
  action :install
end

package "gcc-c++" do
  action :install
end

#package 'http://ftp-srv2.kddilabs.jp/Linux/distributions/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm' do
#  not_if 'rpm -q epel-release-6-8.noarch.rpm '
#  end

package "htop" do
  action :install
end

#package 'http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm' do
#  not_if 'rpm -ivh rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm'
#  end

package "tmux" do
  action :install
end
