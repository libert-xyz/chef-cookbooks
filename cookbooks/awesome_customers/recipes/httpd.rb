#
# Cookbook Name:: awesome_customers
# Recipe:: httpd
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Install Apache and start the service.
httpd_service 'customers' do
  mpm 'prefork'
  action [:create, :start]
end

# Add the site configuration.
#The name customers will produce a service named httpd-customers.

httpd_config 'customers' do
  instance 'customers'
  source 'customers.conf.erb'
  notifies :restart, 'httpd_service[customers]'
end

# Create the document root directory.
directory node['awesome_customers']['document_root'] do
  recursive true
end

# Write the home page.
# file "#{node['awesome_customers']['document_root']}/index.html" do
#   content '<html>This is a placeholder</html>'
#   mode '0644'
#   owner node['awesome_customers']['user']
#   group node['awesome_customers']['group']
# end

# Write the home page.
template "#{node['awesome_customers']['document_root']}/index.php" do
  source 'index.php.erb'
  mode '0644'
  owner node['awesome_customers']['user']
  group node['awesome_customers']['group']
end

##write php info

template "#{node['awesome_customers']['document_root']}/info.php" do
  source 'info.php.erb'
  mode '0644'
  owner node['awesome_customers']['user']
  group node['awesome_customers']['group']
end



# Install the mod_php Apache module.
httpd_module 'php' do
  instance 'customers'
end

# Install php-mysql.
package 'php-mysql' do
  action :install
  notifies :restart, 'httpd_service[customers]'
end
