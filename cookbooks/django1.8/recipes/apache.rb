#
# Cookbook Name:: django1.8
# Recipe:: apache
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


httpd_service 'django' do
  mpm 'prefork'
  action [:create, :start]
end


httpd_config 'django' do
  instance 'django'
  source 'httpd.conf.erb'
  notifies :restart, 'httpd_service[django]'
  action :create
end


httpd_module 'wsgi' do
  instance 'django'
  action :create
end
