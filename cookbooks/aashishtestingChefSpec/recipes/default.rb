#
# Cookbook Name:: aashishtestingChefSpec
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
begin
  include_recipe "vim::#{node['vim']['install_method']}"
rescue Chef::Exceptions::RecipeNotFound
  Chef::Log.warn "A #{node['vim']['install_method']} recipe does not exist for the platform_family: #{node['platform_family']}"
end
