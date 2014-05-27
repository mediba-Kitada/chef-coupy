#
# Cookbook Name:: fluentd
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file "/tmp/install-redhat.sh" do
  source "http://toolbelt.treasuredata.com/sh/install-redhat.sh"
end

bash "install-redhat" do
  code <<-EOL
    sh /tmp/install-redhat.sh
  EOL
end

package "td-agent" do
  action :install
end