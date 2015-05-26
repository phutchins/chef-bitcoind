default['bitcoind']['install_method'] = 'source'
default['bitcoind']['user'] = 'bitcoind'
default['bitcoind']['group'] = 'bitcoind'
default['bitcoind']['home'] = '/opt/bitcoind'
default['bitcoind']['checkblocks'] = 288

# Install from source
default['bitcoind']['source']['source_dir'] = '/opt/bitcoind/bitcoind'
default['bitcoind']['source']['git_repo'] = 'https://github.com/bitcoin/bitcoin.git'
default['bitcoind']['source']['git_revision'] = 'v0.9.5'
default['bitcoind']['source']['bin_location'] = '/usr/local/bin'
default['bitcoind']['source']['bin_name'] = 'bitcoind'

# BDB Compilation and Install
default['bitcoind']['db']['source_url'] = "http://download.oracle.com/berkeley-db/"
default['bitcoind']['db']['filename'] = "db-4.8.30.NC"
default['bitcoind']['db']['extension'] = ".tar.gz"
default['bitcoind']['db']['bdb_prefix'] = "/opt/bitcoind/db4"
