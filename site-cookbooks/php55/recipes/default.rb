#
# Cookbook Name:: php55
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{php php-pear php-mbstring php-devel php-mysql php-gd php-mysql}.each do |pkg|
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