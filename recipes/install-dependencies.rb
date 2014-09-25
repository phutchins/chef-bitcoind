%w[build-essential autoconf libboost-all-dev libssl-dev libprotobuf-dev protobuf-compiler libqt4-dev libqrencode-dev].each do |pkg|
  package pkg do
    action :install
  end
end

remote_file File.join(Chef::Config[:file_cache_path], node['bitcoind']['db']['filename']) do
  source File.join(node['bitcoind']['db']['source_url'], node['bitcoind']['db']['filename'] + node['bitcoind']['db']['extension'])
  notifies :run, "script[extract_db]", :immediately
  notifies :run, "script[install_db]", :immediately
end

script "extract_db" do
  cwd node['bitcoind']['home']
  command "tar -xvf #{File.join(Chef::Config[:file_cache_path], node['bitcoind']['db']['filename'] + node['bitcoind']['db']['extension'])} -C #{node['bitcoind']['home']}"
  creates File.join(node['bitcoind']['home'], node['bitcoind']['db']['filename'])
end

link File.join(node['bitcoind']['home'], "db") do
  to File.join(node['bitcoind']['home'], node['bitcoind']['db']['file_name'])
  action :create
end

script "install_db" do
  cwd File.join(node['bitcoind']['home'], node['bitcoind']['db']['file_name'], 'build_unix')
  code <<-EOH
mkdir -p build
BDB_PREFIX=$(pwd)/build
../dist/configure --disable-shared --enable-exx --with-pic --prefix=$BDB_PREFIX
make install
cd ../..
  EOH
end
