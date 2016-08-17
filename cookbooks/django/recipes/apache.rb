#
# Cookbook Name:: django
# Recipe:: apache
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


httpd_service 'web' do
  listen_ports ['80','443']
  #servername node['webserver']['fqdn']
  #action [:create, :start]
  action :create
end

httpd_module 'ssl' do
  action :create
end

httpd_module 'wsgi' do
  action :create
end

template '/etc/httpd-web/conf/httpd.conf' do
  source 'httpd.conf.erb'
end

httpd_config 'vhost1' do
  source 'config.erb'
  instance 'web'
  notifies :start, 'httpd_service[web]'
  action :create
end
