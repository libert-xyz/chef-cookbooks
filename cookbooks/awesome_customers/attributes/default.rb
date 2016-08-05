def random_password
  require 'securerandom'
  SecureRandom.base64
end



default['firewall']['allow_ssh'] = true
default['firewall']['firewalld']['permanent'] = true
default['awesome_customers']['open_ports'] = 80

default['awesome_customers']['user'] = 'web_admin'
default['awesome_customers']['group'] = 'web_admin'
default['awesome_customers']['document_root'] = '/var/www/customers/public_html'

#normal_unless sets the node attribute only if the attribute has no value.
normal_unless['awesome_customers']['database']['root_password'] = random_password
normal_unless['awesome_customers']['database']['admin_password'] = random_password

default['awesome_customers']['database']['dbname'] = 'my_company'
default['awesome_customers']['database']['host'] = '127.0.0.1'
default['awesome_customers']['database']['root_username'] = 'root'
default['awesome_customers']['database']['admin_username'] = 'db_admin'
