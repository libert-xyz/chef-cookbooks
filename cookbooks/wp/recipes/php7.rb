#
# Cookbook Name:: wp
# Recipe:: php7
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


execute 'script' do
  command 'bash ~/setup.sh'
  action :nothing
end


execute 'php-install' do
  command 'yum install mod_php70u php70u-cli php70u-mysqlnd -y'
  action :nothing
end


execute 'curl' do
  not_if ::File.exists?("~/setup.sh")
  command "curl https://setup.ius.io/ > ~/setup.sh"
  notifies :run, 'execute[script]' , :immediately
  notifies :run, 'execute[php-install]' , :immediately

end
