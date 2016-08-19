#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


include_recipe 'selinux::permissive'

package 'java-1.7.0-openjdk' do
  action :install
end


include_recipe 'jenkins::install'
