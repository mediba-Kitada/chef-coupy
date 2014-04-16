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

mysql_connection_info = {
  :host => "localhost",
  :username => "root",
}

mysql_database "coupy" do
  connection mysql_connection_info
  action :create
end

mysql_database_user "coupy_view" do
  connection mysql_connection_info
  password node["mysql"]["coupy_password"]
  database_name "coupy"
  privileges [:all]
  action [:create, :grant]
end