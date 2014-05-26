#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "httpd" do
  action :install
  #version "2.2.15-29.el6.centos"
end

directory "/var/log/httpd" do
  mode 00777
  user "apache"
  group "apache"
  action :create
end

service "httpd" do
  supports :status => true,:restart => true,:reload => true
  action [:enable,:start]
end

template "/etc/httpd/conf/httpd.conf" do 
  owner "apache"
  group "apache"
  notifies :reload,'service[httpd]'
end