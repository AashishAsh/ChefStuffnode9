#
# Cookbook Name:: Nginx
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.
package 'nginx' do
  action :install
end
template '/etc/nginx/sites-enabled/default' do
  source 'default.erb'
  owner 'root'
  group 'root'
  mode '0755'
end
service 'nginx' do
  supports :status => true, :reload => true, :reload => true
  action [:reload, :enable]
end
execute 'increase_port_range' do
  command 'sudo sysctl -w net.ipv4.ip_local_port_range="20000 64000"'
  action :run
end
