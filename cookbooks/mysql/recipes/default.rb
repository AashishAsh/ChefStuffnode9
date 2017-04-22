#
# Cookbook Name:: .
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.
mysql_client 'default' do
 action :create
end

mysql_service 'foo' do
  port '3306'
  version '5.5'
  initial_root_password 'change-me'
  action [:create, :start]
end
#You can put extra configuration into the conf.d directory by using the mysql_config resource, like this:
#mysql_config 'foo' do
#  source 'my_extra_settings.erb'
#  notifies :restart, 'mysql_service[foo]'
#  action :create
#end
