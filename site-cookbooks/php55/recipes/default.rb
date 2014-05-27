#
# Cookbook Name:: php55
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{php php-pear php-mbstring php-devel php-gd php-mysql php-pecl-apc php-pecl-zendopcache}.each do |pkg|
  package pkg do
    options "--enablerepo=remi,remi-php55"
    action :install
  end
end

template "/etc/php.ini" do
  owner "apache"
  group "apache"
  notifies :reload,'service[httpd]'
end

directory "/var/www/apc-info-monitor" do
  mode 00766
  user "apache"
  group "apache"
  action :create
end

cookbook_file "/var/www/apc-info-monitor/apc.php" do
  owner "apache"
  group "apache"
  mode 00755
  notifies :restart,'service[httpd]'
end