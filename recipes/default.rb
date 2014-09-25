#
# Cookbook Name:: bitcoind
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

case node['bitcoind']['install_method']
when "source"
  include_recipe "bitcoind::install-source"
when "package"
  include_recipe "bitcoind::install-package"
else
  fail "No install method defined. Please define node['bitcoind']['install_method']"
end

template File.join(node['bitcoind']['data_dir'], 'bitcoind.conf') do
  owner node['bitcoind']['user']
  group node['bitcoind']['group']
  action :create
end

template "/etc/init/bitcoind" do
  source "bitcoind.upstart.erb"
  mode 0644
  variables ({
    :bitcoind_user => node['bitcoind']['user'],
    :bitcoind_group => node['bitcoind']['group'],
    :bitcoind_home => node['bitcoind']['source']['home'],
    :bitcoind_bin_location => node['bitcoind']['source']['bin_location'],
    :bitcoind_bin_name => node['bitcoind']['source']['bin_name'],
    :bitcoind_options => node['bitcoind']['options']
  })
end

service "bitcoind" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end
