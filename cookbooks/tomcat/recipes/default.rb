#
# Cookbook Name:: tomcat
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'selinux::disabled'


package 'java-1.7.0-openjdk-devel' do
  action :install
end

group 'tomcat' do
  action :create
end

user 'tomcat' do
  manage_home false
  home node['tomcat']['path']
  shell '/bin/nologin'
  group 'tomcat'
end

remote_file '/root/apache-tomcat-8.5.4.tar.gz' do
  source node['tomcat']['download']
  action :create
  not_if do ::File.exists?('/root/apache-tomcat-8.5.4.tar.gz') end
end

execute 'install' do
  command 'tar xvf /root/apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1'
  not_if do ::File.exists?('/opt/tomcat/conf') end
end

directory "#{node['tomcat']['path']}/conf" do
  group 'tomcat'
  mode '0070'
  #recursive true
end

#change this
execute 'chmod g+r /opt/tomcat/conf/*'
execute 'chgrp -R tomcat /opt/tomcat/conf'
execute 'chown -R tomcat /opt/tomcat/webapps/ /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/ /opt/tomcat/bin/ /opt/tomcat/lib/'

template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end


#change this
execute 'systemctl daemon-reload'


service 'tomcat' do
  action [:start, :enable]
end
