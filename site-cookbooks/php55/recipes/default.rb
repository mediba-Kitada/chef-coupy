#
# Cookbook Name:: php55
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "php" do
  action :install
  options "--enablerepo=remi,remi-php55"
  version "5.5.10-1.el6.remi.1"
end

%w{php-pear php-mbstring php-devel php-mysql php-gd php-mysql}.each do |pkg|
  package pkg do
    options "--enablerepo=remi,remi-php55"
    action :install
  end
end