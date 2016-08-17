#
# Cookbook Name:: django
# Recipe:: python
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


include_recipe 'poise-python'


python_virtualenv "#{node['django']['path']}/venv"



package 'git' do
  action :install
end

git "#{node['django']['path']}/booklos.com" do
  repository node['django']['repository']
  revision 'prod'
  action :sync
end


pip_requirements "#{node['django']['path']}/#{node['django']['fqdn']}/requirements.txt"
