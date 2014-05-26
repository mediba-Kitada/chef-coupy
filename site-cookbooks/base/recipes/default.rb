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

link "/etc/localtime" do
  only_if "find /etc/localtime"
  to "/usr/share/zoneinfo/Asia/Tokyo"
end

%w{git telnet wget zsh nkf tig vim}.each do |pkg|
  package pkg do
    action :install
    options "--enablerepo=epel"
  end
end

user "apache" do
  comment "apache"
  shell "/sbin/nologin"
  password nil
  supports :create => true
end

group "apache" do
  gid 48
  members ['apache']
  action :create
end

remote_file "/tmp/yii.tar.gz" do
  source "https://github.com/yiisoft/yii/releases/download/1.1.14/yii-1.1.14.f0fee9.tar.gz"
end

bash "instal-yii" do
  code <<-EOL
    tar xfvz /tmp/yii.tar.gz -C /var/www/
  EOL
end

link "/var/www/yii" do
  to "/var/www/yii-1.1.14.f0fee9"
end