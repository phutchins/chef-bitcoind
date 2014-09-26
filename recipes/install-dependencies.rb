%w[build-essential autogen autoconf libboost-all-dev libssl-dev libprotobuf-dev openssl protobuf-compiler libqt4-dev libqrencode-dev].each do |pkg|
  package pkg do
    action :install
  end
end

remote_file File.join(Chef::Config[:file_cache_path], node['bitcoind']['db']['filename'] + node['bitcoind']['db']['extension']) do
  source File.join(node['bitcoind']['db']['source_url'], node['bitcoind']['db']['filename'] + node['bitcoind']['db']['extension'])
  notifies :run, "bash[extract_db]", :immediately
  notifies :run, "bash[install_db]", :immediately
end

bash 'extract_db' do
  code <<-EOH
tar xzf #{File.join(Chef::Config[:file_cache_path], node['bitcoind']['db']['filename'] + node['bitcoind']['db']['extension'])} -C #{node['bitcoind']['home']}
  EOH
  not_if { ::File.exists?(File.join(node['bitcoind']['home'], node['bitcoind']['db']['filename'])) }
end

link File.join(node['bitcoind']['home'], "db") do
  owner node['bitcoind']['user']
  group node['bitcoind']['group']
  to File.join(node['bitcoind']['home'], node['bitcoind']['db']['filename'])
  action :create
end

bash "install_db" do
  cwd File.join(node['bitcoind']['home'], node['bitcoind']['db']['filename'], 'build_unix')
  code <<-EOH
mkdir -p build
BDB_PREFIX=$(pwd)/build
../dist/configure --disable-shared --enable-exx --with-pic --prefix=$BDB_PREFIX
make install
cd ../..
  EOH
  not_if { ::File.exists?(File.join(node['bitcoind']['home'], node['bitcoind']['db']['filename'], "build_unix/build/bin/db_stat")) }
end
