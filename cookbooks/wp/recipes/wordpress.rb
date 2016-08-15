#
# Cookbook Name:: wp
# Recipe:: wordpress
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

root_password = data_bag_item("mysql_pass","pass")

remote_file "/root/latest.tar.gz" do
  #if_not FILE.exists?('/root/latest.tar.gz')
  source node['wp']['wp_package']
  action :create
  notifies :run, "execute[untar]", :immediately
end

execute "untar" do
  command "tar -xvzf /root/latest.tar.gz"
  notifies :run, "execute[move]", :immediately
  #action: nothing
end

execute "move" do
  command "cp -r /wordpress/* #{node['wp']['wp_path']}"
  #action: nothing
end

# execute "permissions" do
# command "chown -R apache:apache #{node['wp']['wp_path']}"
# notifies :run, "execute[template]"
# action: nothing
# end

template "#{node['wp']['wp_path']}/wp-config.php" do
  source 'wp-config.php.erb'
  variables(:pass => root_password['pass'])
end
