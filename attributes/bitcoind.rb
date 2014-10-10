# Default settings for bitcoind configuration file
default['bitcoind']['config']['testnet'] = '0'
default['bitcoind']['config']['irc'] = '1'
default['bitcoind']['config']['dnsseed'] = '1'
default['bitcoind']['config']['upnp'] = '1'
default['bitcoind']['config']['proxy'] = nil
default['bitcoind']['config']['server'] = '1'
default['bitcoind']['config']['rpcssl'] = '0'
default['bitcoind']['config']['rpcuser'] = SecureRandom.hex
default['bitcoind']['config']['rpcpassword'] = SecureRandom.hex
default['bitcoind']['config']['port'] = nil
default['bitcoind']['config']['rpcport'] = nil
default['bitcoind']['config']['rpcallowip'] = ['127.0.0.1']
default['bitcoind']['config']['rpcconnect'] = []
default['bitcoind']['config']['gen'] = '0'
default['bitcoind']['config']['alertnotify'] = nil
default['bitcoind']['config']['checkblocks'] = nil
default['bitcoind']['config']['rpcsslcertificatechainfile'] = nil
default['bitcoind']['config']['rpcsslprivatekeyfile'] = nil
default['bitcoind']['config']['txindex'] = '0'
default['bitcoind']['config']['listen'] = '0'

# Daemon configuration
default['bitcoind']['config']['options'] = ""
default['bitcoind']['config']['data_dir'] = "/opt/bitcoind"

# Configure instances
# An instance would be configured like so, overriding any defaults needed
# default['bitcoind']['instances']['bitcoin']['name'] = 'bitcoin'
