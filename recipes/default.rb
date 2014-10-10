#
# Cookbook Name:: bitcoind
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

user node['bitcoind']['user'] do
  home node['bitcoind']['home']
  shell "/bin/bash"
  action :create
end

directory node['bitcoind']['home'] do
  user node['bitcoind']['user']
  group node['bitcoind']['group']
  action :create
end

if node['bitcoind']['instances'].nil?
  node['bitcoind']['instances']['bitcoin']['name'] = 'bitcoin'
end

node['bitcoind']['instances'].each do |instance|
  config_merged = instance[1].to_hash
  node['bitcoind']['config'].each do |key, value|
    config_merged[key] = value unless config_merged.has_key? key
  end

  config_merged['data_dir'] ||= node['bitcoind']['data_dir']

  directory config_merged['data_dir'] do
    user node['bitcoind']['user']
    group node['bitcoind']['group']
    action :create
  end
end

case node['bitcoind']['install_method']
when "source"
  include_recipe "bitcoind::install-source"
when "package"
  include_recipe "bitcoind::install-package"
else
  fail "No install method defined. Please define config_merged['install_method']"
end

node['bitcoind']['instances'].each do |instance|
  config_merged = instance[1].to_hash
  node['bitcoind']['config'].each do |key, value|
    config_merged[key] = value unless config_merged.has_key? key
  end

  template "/etc/init/#{config_merged['name']}.conf" do
    source "bitcoind.upstart.erb"
    mode 0644
    variables ({
      :bitcoind_name => config_merged['name'],
      :bitcoind_user => node['bitcoind']['user'],
      :bitcoind_group => node['bitcoind']['group'],
      :bitcoind_data_dir => config_merged['data_dir'],
      :bitcoind_home => node['bitcoind']['home'],
      :bitcoind_bin_location => node['bitcoind']['source']['bin_location'],
      :bitcoind_bin_name => node['bitcoind']['source']['bin_name'],
      :bitcoind_options => config_merged['options']
    })
  end

  template File.join(config_merged['data_dir'], 'bitcoin.conf') do
    owner node['bitcoind']['user']
    group node['bitcoind']['group']
    variables ({
      :bitcoind_testnet => config_merged['testnet'],
      :bitcoind_irc => config_merged['irc'],
      :bitcoind_dnsseed => config_merged['dnsseed'],
      :bitcoind_upnp => config_merged['upnp'],
      :bitcoind_txindex => config_merged['txindex'],
      :bitcoind_listen => config_merged['listen'],
      :bitcoind_server => config_merged['server'],
      :bitcoind_rpcuser => config_merged['rpcuser'],
      :bitcoind_rpcpassword => config_merged['rpcpassword'],
      :bitcoind_rpcallowip => config_merged['rpcallowip'],
      :bitcoind_rpcport => config_merged['rpcport'],
      :bitcoind_port => config_merged['port'],
      :bitcoind_rpcconnect => config_merged['rpcconnect'],
      :bitcoind_rpcssl => config_merged['rpcssl'],
      :bitcoind_rpcsslcertificatechainfile => config_merged['rpcsslcertificatechainfile'],
      :bitcoind_rpcsslprivatekeyfile => config_merged['rpcsslprivatekeyfile'],
      :bitcoind_gen => config_merged['gen'],
      :bitcoind_alertnotify => config_merged['alertnotify'],
      :bitcoind_checkblocks => config_merged['checkblocks']
    })
    action :create
    notifies :restart, "service[#{config_merged['name']}]"
  end

  service config_merged['name'] do
    provider Chef::Provider::Service::Upstart
    supports :status => true, :restart => true
    action [ :enable, :start ]
  end
end
