#root_password = data_bag_item("mysql_pass","pass")


default['wp']['service'] = 'wp'
default['wp']['database'] = 'wp-chef'
default['wp']['host'] = 'localhost'
default['wp']['root_user'] = 'root'
#default['wp']['root_password'] = root_password["pass"]


#Admin user
#default['wp']['admin_username']


#Wordoress path
default['wp']['wp_path'] = '/var/www/wp'

#Wordpress install

default['wp']['wp_package'] = 'https://wordpress.org/latest.tar.gz'

##Repository

default["wp"]["url"] = 'https://github.com/rschmidtz/wordpress.git'
default["wp"]["revision"] = 'master'
