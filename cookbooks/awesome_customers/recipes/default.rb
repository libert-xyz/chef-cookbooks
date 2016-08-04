#
# Cookbook Name:: awesome_customers
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


include_recipe 'selinux::disabled'
include_recipe 'awesome_customers::firewall'
include_recipe 'awesome_customers::web_user'
include_recipe 'awesome_customers::httpd'
