#
# Cookbook Name:: webserver
# Recipe:: apache
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


httpd_service 'web' do
  listen_ports ['80','443']
  #servername node['webserver']['fqdn']
  action [:create, :start]
end

httpd_module 'ssl' do
  action :create
end

httpd_config 'vhost1' do
  source 'config.erb'
  instance 'web'
  notifies :restart, 'httpd_service[web]'
  action :create
end
