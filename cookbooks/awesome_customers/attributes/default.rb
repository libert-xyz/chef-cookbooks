default['firewall']['allow_ssh'] = true
default['firewall']['firewalld']['permanent'] = true
default['awesome_customers']['open_ports'] = 80

default['awesome_customers']['user'] = 'web_admin'
default['awesome_customers']['group'] = 'web_admin'
default['awesome_customers']['document_root'] = '/var/www/customers/public_html'
