
include_recipe 'poise-python'


# python_runtime 'myapp' do
#   provider :system
#   version '2.7'
# end


python_virtualenv "#{node['django1.8']['path']}/venv"


# python_package 'Django' do
#   version '1.9'
# end

package 'git' do
  action :install
end

git "#{node['django1.8']['path']}/booklos" do
  repository node['django1.8']['repository']
  revision 'prod'
  action :sync
end


pip_requirements "#{node['django1.8']['path']}/booklos/requirements.txt"
