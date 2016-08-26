#
# Cookbook Name:: wp
# Recipe:: apache
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

app_path = node['wp']['wp_path']

package 'httpd' do
  action :install
end

package 'git' do
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


application app_path do
  owner 'apache'
  group 'apache'

  git app_path do
    repository node["wp"]["url"]
  end
end


execute 'permissions' do
  command "chown -R apache:apache #{node['wp']['wp_path']}"
  notifies :restart , 'service[httpd]'
end
