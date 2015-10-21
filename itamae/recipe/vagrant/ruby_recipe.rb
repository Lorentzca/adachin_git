git "/home/#{node["ruby-env"]["user"]}/.rbenv" do
  repository "https://github.com/#{node["ruby-env"]["rbenv_url"]}"
  user node["ruby-env"]["user"]
end

execute "Add rbenv to bash_profile" do
  user node["ruby-env"]["user"]
  command "echo 'export PATH=\"#{node["ruby-env"]["rbenv_path"]}:$PATH\"' >> ~/.bash_profile;" \
    "echo 'eval \"$(rbenv init -)\"' >> ~/.bash_profile"
  not_if "grep 'rbenv init' ~/.bash_profile"
end

directory "/home/#{node["ruby-env"]["user"]}/.rbenv/plugins" do
  owner node["ruby-env"]["user"]
  group node["ruby-env"]["group"]
  mode '0755'
  action :create
end

%w(ruby-build rbenv-default-gems rbenv-gem-rehash).each do |plgin|
  git "/home/#{node["ruby-env"]["user"]}/.rbenv/plugins/#{plgin}" do
    repository "https://github.com/#{node["ruby-env"]["#{plgin}_url"]}"
    user node["ruby-env"]["user"]
  end
end

%w(bundler pry).each do |gem_name|
  execute "Add default gems when installing ruby: #{gem_name}" do
    user node["ruby-env"]["user"]
    command "echo '#{gem_name}' >> ~/.rbenv/default-gems"
    not_if "grep '#{gem_name}' ~/.rbenv/default-gems"
  end
end

node["ruby-env"]["versions"].each do |version|
  execute "Install Ruby v#{version}" do
    user node["ruby-env"]["user"]
    command "#{node["ruby-env"]["rbenv_path"]}/rbenv install #{version}"
    not_if "#{node["ruby-env"]["rbenv_path"]}/rbenv versions | grep #{version}"
  end
end

execute "Set global ruby version #{node["ruby-env"]["global_version"]}" do
  user node["ruby-env"]["user"]
  command "#{node["ruby-env"]["rbenv_path"]}/rbenv global #{node["ruby-env"]["global_version"]}"
end
