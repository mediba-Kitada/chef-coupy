#
# Cookbook Name:: kvs
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "memcached" do
  action :install
end

# デフォルトポート:11211は停止
service "memcached" do
  action [:enable,:stop]
  supports :restart => false, :start => false, :stop => true
end

# ポート:11220
cookbook_file "/etc/sysconfig/memcached-11220.conf" do
  owner "memcached"
  group "memcached"
  mode 00644
end

cookbook_file "/etc/init.d/memcached-11220" do
  owner "root"
  group "root"
  mode 00766
end

service "memcached-11220" do
  action [:enable,:start]
  supports :restart => true, :start => true
end

# ポート:11370
cookbook_file "/etc/sysconfig/memcached-11370.conf" do
  owner "memcached"
  group "memcached"
  mode 00644
end

cookbook_file "/etc/init.d/memcached-11370" do
  owner "root"
  group "root"
  mode 00766
end

service "memcached-11370" do
  action [:enable,:start]
  supports :restart => true, :start => true
end

# ポート:11300
cookbook_file "/etc/sysconfig/memcached-11300.conf" do
  owner "memcached"
  group "memcached"
  mode 00644
end

cookbook_file "/etc/init.d/memcached-11300" do
  owner "root"
  group "root"
  mode 00766
end

service "memcached-11300" do
  action [:enable,:start]
  supports :restart => true, :start => true
end

# ポート:11210
cookbook_file "/etc/sysconfig/memcached-11210.conf" do
  owner "memcached"
  group "memcached"
  mode 00644
end

cookbook_file "/etc/init.d/memcached-11210" do
  owner "root"
  group "root"
  mode 00766
end

service "memcached-11210" do
  action [:enable,:start]
  supports :restart => true, :start => true
end

# ポート:11200
cookbook_file "/etc/sysconfig/memcached-11200.conf" do
  owner "memcached"
  group "memcached"
  mode 00644
end

cookbook_file "/etc/init.d/memcached-11200" do
  owner "root"
  group "root"
  mode 00766
end

service "memcached-11200" do
  action [:enable,:start]
  supports :restart => true, :start => true
end