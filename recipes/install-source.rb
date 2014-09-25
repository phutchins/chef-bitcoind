user node['bitcoind']['user'] do
  home node['bitcoind']['binary']['home']
  shell "/bin/bash"
  supports manage_home: true
end

directory "#{node['bitcoind']['binary']['home']}/.bitcoin" do
  owner node['bitcoind']['user']
  group node['bitcoind']['user']
  mode "0700"
end

include_recipe 'bitcoind::install-dependencies'

template "#{node['bitcoind']['binary']['home']}/.bitcoin/bitcoin.conf" do
  owner node['bitcoind']['user']
  group node['bitcoind']['user']
  mode "0600"
  action :create_if_missing
end

git "bitcoind_repo" do
  user node['bitcoind']['user']
  group node['bitcoind']['user']
  destination node['bitcoind']['source']['source_dir']
  repository node['bitcoind']['source']['git_repo']
  revision node['bitcoind']['source']['git_revision']
  action :sync
  notifies :run, "script[configure_build_bitcoind]", :immediately
end

script "configure_build_bitcoind" do
  interpreter 'bash'
  #user node['bitcoind']['user']
  cwd node['bitcoind']['source']['source_dir']
  code <<-EOH
./autogen.sh
./configure CPPFLAGS="-I${BDB_PREFIX}/include/ -O2" LDFLAGS="-L${BDB_PREFIX}/lib/"
make
make install
  EOH
end
