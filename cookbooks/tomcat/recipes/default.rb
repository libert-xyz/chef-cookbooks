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


execute 'group-reading' do
  command 'chmod g+r /opt/tomcat/conf/*'
  action :nothing
end

execute 'change-reading-recursive' do
  command 'chgrp -R tomcat /opt/tomcat/conf'
  action :nothing
end

execute 'change-permisions' do
  command 'chown -R tomcat /opt/tomcat/webapps/ /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/ /opt/tomcat/bin/ /opt/tomcat/lib/'
  action :nothing
end

execute 'install-tomcat' do
  command 'tar xvf /root/apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1'
  action :nothing
  #not_if do ::File.exists?('/opt/tomcat/conf') end
end

remote_file '/root/apache-tomcat-8.5.4.tar.gz' do
  not_if do ::File.exists?('/root/apache-tomcat-8.5.4.tar.gz') end
  source node['tomcat']['download']
  action :create
  notifies :run, 'execute[install-tomcat]', :immediately
  notifies :run, 'execute[group-reading]', :immediately
  notifies :run, 'execute[change-reading-recursive]', :immediately
  notifies :run, 'execute[change-permisions]', :immediately

end


directory "#{node['tomcat']['path']}/conf" do
  mode '0070'
end

template '/opt/tomcat/conf/tomcat-users.xml' do
  source 'tomcat-user.xml.erb'
end


#change this
# execute 'chmod g+r /opt/tomcat/conf/*'
# execute 'chgrp -R tomcat /opt/tomcat/conf'
# execute 'chown -R tomcat /opt/tomcat/webapps/ /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/ /opt/tomcat/bin/ /opt/tomcat/lib/'


template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end

#change this
execute 'systemctl daemon-reload'


service 'tomcat' do
  action [:start, :enable]
end

template '/opt/tomcat/conf/Catalina/localhost/manager.xml' do
  source 'manager.xml.erb'
  group 'tomcat'
end
