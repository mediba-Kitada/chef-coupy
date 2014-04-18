#
# Cookbook Name:: rsyslog
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "rsyslog" do
  action :install
end

service "rsyslog" do
  supports :status => true, :restart => true, :reload => true
  action [:enable,:start]
end