#
# Cookbook Name:: wp
# Recipe:: mysql
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

#include_recipe 'mysql'

#root_password = data_bag_item("mysql_pass","pass", IO.read('/home/tux/Documents/databag_secret'))
root_password = data_bag_item("mysql_pass","pass")
#admin_password = data_bag_item("mysql_pass","admin")

mysql_service node['wp']['service'] do
  port "3306"
  version "5.7"
  initial_root_password root_password["pass"]
  #initial_root_password node["wp"]["root_password"]
  action [:create, :start]
end

mysql2_chef_gem 'default' do
  action :install
end

mysql_database node['wp']['database'] do
  connection(
          :host => node['wp']['host'],
          :username => node['wp']['root_user'],
          :socket => "/var/run/mysql-#{node['wp']['service']}/mysqld.sock",
          :password => root_password['pass']
          )
  action :create
end

# Add a database user.
# mysql_database_user node['wp']['admin_username'] do
#   connection(
#           :host => node['wp']['host'],
#           :username => node['wp']['root_user'],
#           :socket => "/var/run/mysql-#{node['wp']['service']}/mysqld.sock",
#           :password => root_password['pass']
#           )
#   password admin_password['pass']
#   database_name node['wp']['database']
#   host node['wp']['host']
#   action [:create, :grant]
# end
