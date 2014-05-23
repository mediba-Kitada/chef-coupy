#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'database::mysql'

package "mysql-server" do
  action :install
  options "--enablerepo=remi,remi-php55"
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

mysql_database "cms" do
  connection mysql_connection_info
  action :create
end

mysql_database "event" do
  connection mysql_connection_info
  action :create
end

mysql_database "resource" do
  connection mysql_connection_info
  action :create
end

mysql_database_user "awsuser" do
  connection mysql_connection_info
  password node["mysql"]["aws_password"]
  database_name "cms"
  privileges [:all]
  action [:create, :grant]
end

mysql_database_user "awsuser" do
  connection mysql_connection_info
  password node["mysql"]["aws_password"]
  database_name "event"
  privileges [:all]
  action [:create, :grant]
end

mysql_database_user "awsuser" do
  connection mysql_connection_info
  password node["mysql"]["aws_password"]
  database_name "resource"
  privileges [:all]
  action [:create, :grant]
end
