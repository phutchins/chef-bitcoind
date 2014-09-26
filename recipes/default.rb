#
# Cookbook Name:: bitcoind
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.


template "/etc/init/bitcoind.conf" do
  source "bitcoind.upstart.erb"
  mode 0644
  variables ({
    :bitcoind_user => node['bitcoind']['user'],
    :bitcoind_group => node['bitcoind']['group'],
    :bitcoind_data_dir => node['bitcoind']['data_dir'],
    :bitcoind_home => node['bitcoind']['home'],
    :bitcoind_bin_location => node['bitcoind']['source']['bin_location'],
    :bitcoind_bin_name => node['bitcoind']['source']['bin_name'],
    :bitcoind_options => node['bitcoind']['options']
  })
  action :create
end

[node['bitcoind']['home'], node['bitcoind']['data_dir'], File.join(node['bitcoind']['home'], ".bitcoin")].each do |dir|
  directory dir do
    user node['bitcoind']['user']
    group node['bitcoind']['group']
    action :create
  end
end

user node['bitcoind']['user'] do
  home node['bitcoind']['home']
  shell "/bin/bash"
end

case node['bitcoind']['install_method']
when "source"
  include_recipe "bitcoind::install-source"
when "package"
  include_recipe "bitcoind::install-package"
else
  fail "No install method defined. Please define node['bitcoind']['install_method']"
end

template File.join(node['bitcoind']['home'], '.bitcoin/bitcoin.conf') do
  owner node['bitcoind']['user']
  group node['bitcoind']['group']
  action :create_if_missing
  notifies :restart, "service[bitcoind]"
end


service "bitcoind" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true
  action [ :enable, :start ]
end
