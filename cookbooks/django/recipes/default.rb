#
# Cookbook Name:: django
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'selinux::permissive'

package 'libxslt-devel' do
  action :install
end

package 'libxml2-devel' do
  action :install
end


package 'gcc' do
  action :install
end


package 'python-lxml' do
  action :install
end

directory "/var/www" do
  mode '0755'
  action :create
end

directory "/var/www/#{node['django']['fqdn']}" do
  mode '0755'
  action :create
end

include_recipe 'django::python'


include_recipe 'django::apache'



execute 'permissions' do
  command "chown -R apache:apache #{node['django']['path']}/#{node['django']['fqdn']}"
end
