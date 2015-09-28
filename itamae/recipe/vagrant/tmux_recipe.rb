package 'http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm' do
  not_if 'rpm -ivh rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm'
end

package "tmux" do
  action :install
end
