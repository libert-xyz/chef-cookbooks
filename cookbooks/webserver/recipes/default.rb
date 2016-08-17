#
# Cookbook Name:: webserver
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.



include_recipe 'selinux::permissive'
include_recipe 'webserver::apache'

directory "/var/www/#{node['webserver']['fqdn']}" do
  owner 'apache'
  group 'apache'
  mode '0755'
  action :create
end


template "/var/www/#{node['webserver']['fqdn']}/index.html" do
  source "index.html.erb"
  owner 'apache'
  group 'apache'
  mode '0664'
end
