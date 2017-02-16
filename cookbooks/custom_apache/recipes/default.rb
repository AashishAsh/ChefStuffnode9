#
# Cookbook Name:: custom_apache
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#package 'tree' do
# action :install
#end
#%w{httpd tree vim emacs}.each do |pkg|
#package pkg do
# action :upgrade
#end
#end
package 'httpd' do
 action :install
end
service 'httpd' do
 action [ :enable,:start ]
end
cookbook_file '/var/www/html/index.html' do
 source 'index.html'
 mode 644
end
#file '/etc/modf' do
#action :create
#end
