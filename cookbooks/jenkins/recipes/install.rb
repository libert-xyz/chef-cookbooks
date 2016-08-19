#
# Cookbook Name:: jenkins
# Recipe:: install
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


package 'wget' do
  action :install
end

execute 'wget-repo' do
  not_if do ::File.exists?('/etc/yum.repos.d/jenkins.repo') end
  command 'wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo'
  notifies :run, 'execute[rpm-import]', :immediately
end

execute 'rpm-import' do
  command 'rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key'
  action :nothing
end

package 'jenkins' do
  action :install
end

service 'jenkins' do
  action [:enable, :start]
end
