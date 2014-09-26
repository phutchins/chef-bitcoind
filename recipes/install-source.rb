execute "apt_get_update" do
  command "apt-get update"
  not_if { ::File.exists?(node['bitcoind']['home']) }
end

include_recipe 'bitcoind::install-dependencies'

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
  user node['bitcoind']['user']
  group node['bitcoind']['user']
  cwd node['bitcoind']['source']['source_dir']
  code <<-EOH
./autogen.sh
./configure CPPFLAGS="-I${BDB_PREFIX}/include/ -O2" LDFLAGS="-L${BDB_PREFIX}/lib/"
make
sudo make install
  EOH
  not_if { ::File.exists?(File.join(node['bitcoind']['source']['bin_location'], node['bitcoind']['source']['bin_name'])) }
end
