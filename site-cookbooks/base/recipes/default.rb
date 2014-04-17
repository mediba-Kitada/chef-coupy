#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

yum_repository "epel" do
  description "eple"
  mirrorlist "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=$basearch"
  gpgkey "http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6"
  fastestmirror_enabled true
  action :create
end

yum_repository 'remi' do
  description 'Les RPM de Remi - Repository'
  baseurl 'http://rpms.famillecollet.com/enterprise/6/remi/x86_64/'
  gpgkey 'http://rpms.famillecollet.com/RPM-GPG-KEY-remi'
  fastestmirror_enabled true
  action :create
end

yum_repository 'remi-php55' do
  description 'Les RPM de remi de PHP 5.5'
  baseurl 'http://rpms.famillecollet.com/enterprise/6/php55/$basearch/'
  mirrorlist 'http://rpms.famillecollet.com/enterprise/6/php55/mirror'
  gpgkey 'http://rpms.famillecollet.com/RPM-GPG-KEY-remi'
end

package "git" do
  action :install
end

directory "/var/www/coupy" do
  owner "apache"
  group "apache"
  action :create
end

directory "/home/vagrant/git" do
  owner "vagrant"
  group "vagrant"
  action :create
end

directory "/home/vagrant/.ssh" do
  owner "vagrant"
  group "vagrant"
  action :create
end

cookbook_file "/home/vagrant/.ssh/id_rsa" do
  mode 00600
  owner "vagrant"
  group "vagrant"
end

cookbook_file "/home/vagrant/.ssh/id_rsa.pub" do
  mode 00644
  owner "vagrant"
  group "vagrant"
end

cookbook_file "/home/vagrant/.ssh/config" do
  mode 00644
  owner "vagrant"
  group "vagrant"
end

cookbook_file "/etc/sudoers" do
  mode 00440
  owner "root"
  group "root"
end

git "/home/vagrant/git" do
  repo "git@github.com:mediba-system/coupy.git"
  reference "develop"
  action :checkout
end

link "/var/www/coupy/coupy" do
  to "/home/vagrant/git/coupy/coupy"
end