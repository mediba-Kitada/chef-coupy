#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "mysql-server" do
  action :install
  #version "5.1.67-1.el6_3"
end

service "mysqld" do
  action [:enable,:start]
  supports :restart => true, :start => true
end

template "/etc/my.cnf" do
  owner "mysql"
  group "mysql"
  notifies :restart, 'service[mysqld]'
end