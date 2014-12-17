# chef-bitcoind

This cookbook installs and configures bitcoind and all dependencies.

## Platform:

* Ubuntu
(Currently this is only tested on Ubuntu 14.04 but has been written such that it should support others)


## Cookbooks:
None! :)


## Attributes

<table>
  <tr>
    <td>Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['install_method']</code></td>
    <td>Installation method. Can be source or package.</td>
    <td><code>source</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['user']</code></td>
    <td>The user that bitcoind will be run as</td>
    <td><code>bitcoind</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['group']</code></td>
    <td>The group that the bitcoind user will belong to</td>
    <td><code>bitcoind</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['home']</code></td>
    <td>Home directory for bitcoind user</td>
    <td><code>/opt/bitcoin</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['checkblocks']</code></td>
    <td>How many blocks to check at startup</td>
    <td><code>288</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['source']['source_dir']</code></td>
    <td>Directory that the source code is intalled and compiled</td>
    <td><code>/opt/bitcoind/bitcoind</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['source']['git_repo']</code></td>
    <td>The repository to retrieve the bitcoind source code from</td>
    <td><code>https://github.com/bitcoin/bitcoin.git</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['source']['git_revision']</code></td>
    <td>The version tag or revision to pull from the git repo</td>
    <td><code>v0.9.3</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['source']['bin_location']</code></td>
    <td>Where to install the bitcoind binary</td>
    <td><code>/usr/local/bin</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['source']['bin_name']</code></td>
    <td>Name of the bitcoind binary</td>
    <td><code>bitcoind</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['db']['source_url']</code></td>
    <td>Source URL for berkeley-db</td>
    <td><code>http://download.oracle.com/berkeley-db/</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['db']['filename']</code></td>
    <td>File name of berkeley-db package without extension</td>
    <td><code>db-4.8.30.NC</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['db']['extension']</code></td>
    <td>Extension of berkeley-db filename</td>
    <td><code>.tar.gz</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['db']['bdb_prefix']</code></td>
    <td>Directory to compile bdb</td>
    <td><code>/opt/bitcoind/db4</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['config']['data_dir']</code></td>
    <td>Directory where we create bitcoind folder which contains config and data</td>
    <td><code>/opt/bitcoind</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['config']['testnet']</code></td>
    <td>Use testnet instead of production bitcoin network</td>
    <td><code>0</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['config']['irc']</code></td>
    <td>Source peers from IRC</td>
    <td><code>1</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['config']['dnsseed']</code></td>
    <td>Source peers from DNS</td>
    <td><code>1</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['config']['upnp']</code></td>
    <td>Enable UPNP</td>
    <td><code>1</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['config']['proxy']</code></td>
    <td>Use a proxy</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['config']['server']</code></td>
    <td>Enable server flag</td>
    <td><code>1</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['config']['rpcssl']</code></td>
    <td>Enable SSL over RPC</td>
    <td><code>0</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['config']['rpcuser']</code></td>
    <td>Username for RPC auth</td>
    <td><code>Random</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['config']['rpcpassword']</code></td>
    <td>Password for RPC auth</td>
    <td><code>Random</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['config']['port']</code></td>
    <td>Bitcoind port (nil leaves port set as the default)</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['config']['rpcport']</code></td>
    <td>RPC port (nil leaves rpcport set as the default)</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['config']['rpcallowip']</code></td>
    <td>IP's to allow connections from over RPC</td>
    <td><code>['127.0.0.1']</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['config']['rpcconnect']</code></td>
    <td>Hosts to connect to over RPC</td>
    <td><code>[]</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['config']['gen']</code></td>
    <td>Enable mining</td>
    <td><code>0</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['config']['alertnotify']</code></td>
    <td>Execute command when a relevant alert is received</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['config']['checkblocks']</code></td>
    <td>Blocks to check on startup</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['config']['rpcsslcertificatechainfile']</code></td>
    <td>Your RPC SSL certificate chain file</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['config']['rpcsslprivatekeyfile']</code></td>
    <td>Your RPC SSL private key file</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['config']['txindex']</code></td>
    <td>Enable reindex on startup</td>
    <td><code>0</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['config']['listen']</code></td>
    <td>Listen for connections over RPC</td>
    <td><code>0</code></td>
  </tr>
  <tr>
    <td><code>node['bitcoind']['config']['options']</code></td>
    <td>Extra options for daemon configuration</td>
    <td><code>""</code></td>
  </tr>
</table>

Recipes
=======

## bitcoind::default

Installs and configures bitcoind from source or package depending on value set in `node['bitcoind']['install_method']`

Usage
=====

Add `recipe[chef-bitcoind]` to your node's runlist or role, or include it in another cookbook.

To configure install method, simply set `node['bitcoind']['install_method']` in  your role or wrapper cookbook.

## Multiple Instances Per Host

This cookbook can install configure and maintain multiple instances of bitcoind running on the same host. Using node attributes define one instance per namespace as in the following example.

### Example

This example sets up two bitcoind instances.

One is under the namespace bitcoind and the other is testnet. Make sure to choose different ports for each instance to avoid colision. They will be installed into /opt.

```ruby
node.set['bitcoind']['instances']['bitcoind']['name'] = 'bitcoind'
node.set['bitcoind']['instances']['bitcoind']['data_dir'] = '/opt/bitcoind'
node.set['bitcoind']['instances']['bitcoind']['port'] = '21000'
node.set['bitcoind']['instances']['bitcoind']['rpcport'] = '21001'
node.set['bitcoind']['instances']['bitcoind']['version'] = '90300'

node.set['bitcoind']['instances']['testnet']['name'] = 'testnet'
node.set['bitcoind']['instances']['testnet']['data_dir'] = '/opt/testnet'
node.set['bitcoind']['instances']['testnet']['port'] = '22000'
node.set['bitcoind']['instances']['testnet']['rpcport'] = '22001'
node.set['bitcoind']['instances']['testnet']['version'] = '90300'
```

Testing
=======

## Requirements

You must have VirtualBox(https://www.virtualbox.org/) and Vagrant(http://www.vagrantup.com/) installed.

Install gem dependencies with bundler:

```bash
$ gem install bundler
$ bundle install
```

## Running the tests

```bash
$ bundle exec kitchen test
```

Contributing
============

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Author
==================

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | Philip Hutchins (<flipture@gmail.com>)
| **License:**         | Apache License, Version 2.0

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
