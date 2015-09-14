#
# Cookbook Name:: timezone
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

require 'chef/util/file_edit'

if ['debian','ubuntu'].member? node['platform']
  package "tzdata"

  template "/etc/timezone" do
    source "timezone.conf.erb"
    owner 'root'
    group 'root'
    mode 0644
    notifies :run, 'bash[dpkg-reconfigure tzdata]'
  end

  bash 'dpkg-reconfigure tzdata' do
    user 'root'
    code "/usr/sbin/dpkg-reconfigure -f noninteractive tzdata"
    action :nothing
  end

elsif ['rhel','centos','scientific','amazon'].member? node['platform']
  package "tzdata"

  bash "source_clock" do
    code "source /etc/sysconfig/clock"
    user 'root'
    group 'root'
    action :nothing
  end

  link "/etc/localtime" do
    to "/usr/share/zoneinfo/#{node['timezone']['zone']}"
  end

  template "/etc/sysconfig/clock" do
    source "clock.erb"
    mode 0644
    owner 'root'
    group 'root'
    variables({
       :zone => node['timezone']['zone'],
       :utc => node['timezone']['utc']
    })
   notifies :run, 'bash[source_clock]'
  end

end
