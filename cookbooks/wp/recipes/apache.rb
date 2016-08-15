#
# Cookbook Name:: wp
# Recipe:: apache
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package 'httpd' do
  action :install
end


service 'httpd' do
  action [:enable, :start]
end


template '/etc/httpd/conf/httpd.conf' do
  source 'httpd.conf.erb'
end


directory node['wp']['wp_path'] do
  owner 'apache'
  group 'apache'
end

execute 'permissions' do
  command "chown -R apache:apache #{node['wp']['wp_path']}"
  notifies :restart , 'service[httpd]'
end
