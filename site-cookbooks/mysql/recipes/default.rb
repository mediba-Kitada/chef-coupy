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

mysql_database "pass" do
  connection mysql_connection_info
  action :create
end

mysql_database_user "cake_admin" do
  connection mysql_connection_info
  password node["mysql"]["bdb_password"]
  privileges [:all]
  action [:create, :grant]
end

mysql_database "pass_async" do
  connection mysql_connection_info
  action :create
end

mysql_database_user "pass_async" do
  connection mysql_connection_info
  password node["mysql"]["async_password"]
  privileges [:all]
  action [:create, :grant]
end

bash "migrate-coupyDB" do
  only_if "find /var/www/coupy/doc/ddl/cpydb.coupy.ddl"
  code <<-EOL
    mysql -u root coupy < /var/www/coupy/doc/ddl/cpydb.coupy.ddl
  EOL
end

bash "manipulate-coupyDB" do
  only_if "find /var/www/coupy/doc/dml/cpydb.coupy.dml"
  code <<-EOL
    mysql -u root coupy < /var/www/coupy/doc/dml/cpydb.coupy.dml
  EOL
end

bash "migrate-bdb" do
  only_if "find /var/www/coupy/doc/ddl/bdb.pass.coupon.ddl"
  code <<-EOL
    mysql -u root pass < /var/www/coupy/doc/ddl/bdb.pass.coupon.ddl
  EOL
end

bash "migrate-asyncDB" do
  only_if "find /var/www/coupy/doc/ddl/asyncdb.pass.coupon.ddl"
  code <<-EOL
    mysql -u root pass < /var/www/coupy/doc/ddl/asyncdb.pass.coupon.ddl
  EOL
end

bash "manipulate-async" do
  only_if "find /var/www/coupy/doc/dml/asyncdb.pass.coupon.dml"
  code <<-EOL
    mysql -u root pass_async < /var/www/coupy/doc/dml/asyncdb.pass.coupon.dml
  EOL
end