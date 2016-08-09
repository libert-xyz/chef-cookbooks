#
# Cookbook Name:: django1.8
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


include_recipe 'selinux::permissive'

# execute 'yum-update' do
#   command 'yum -y update'
# end


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

include_recipe 'django1.8::python'


package 'httpd' do
  action :install
end


package 'mod_wsgi' do
  action :install
end

service 'httpd' do
  action [:enable, :start]
end


template '/etc/httpd/conf/httpd.conf' do
  source 'httpd.conf.erb'
  notifies :restart , 'service[httpd]'
end


directory node['django1.8']['path'] do
  owner 'apache'
  group 'apache'
end

execute 'permissions' do
  command "chown -R apache:apache #{node['django1.8']['path']}/booklos"
end

# package 'epel-release' do
#   action :install
# end
#
# package 'python-pip' do
#   action :install
# end
