execute "apt_get_update" do
  command "apt-get update"
  not_if { ::File.exists?(node['bitcoind']['home']) }
end

include_recipe 'chef-bitcoind::install-dependencies'

git "bitcoind_repo" do
  user node['bitcoind']['user']
  group node['bitcoind']['group']
  destination node['bitcoind']['source']['source_dir']
  repository node['bitcoind']['source']['git_repo']
  revision node['bitcoind']['source']['git_revision']
  action :sync
  notifies :run, "script[configure_build_bitcoind]", :immediately
end

script "configure_build_bitcoind" do
  interpreter 'bash'
  user node['bitcoind']['user']
  group node['bitcoind']['group']
  cwd node['bitcoind']['source']['source_dir']
  flags '-l'
  environment Hash[ 'HOME' => node['bitcoind']['home'] ]
  code <<-EOH
./autogen.sh
./configure CPPFLAGS="-I#{node['bitcoind']['db']['bdb_prefix']}/include/ -O2" LDFLAGS="-L#{node['bitcoind']['db']['bdb_prefix']}/lib/"
make
  EOH
  not_if { ::File.exists?(File.join(node['bitcoind']['source']['source_dir'], 'src', node['bitcoind']['source']['bin_name'])) }
end

script "install_bitcoind" do
  interpreter 'bash'
  user 'root'
  group 'root'
  cwd node['bitcoind']['source']['source_dir']
  flags '-l'
  code <<-EOH
echo `whoami` > /root/test.tmp
make install
  EOH
  not_if { ::File.exists?(File.join(node['bitcoind']['source']['bin_location'], node['bitcoind']['source']['bin_name'])) }
end
