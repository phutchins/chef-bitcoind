require_relative '../spec_helper'
require 'pry'

describe 'bitcoind::default' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set['bitcoind']['instances']['testnet']['name'] = 'testnet'
      node.set['bitcoind']['user'] = 'bitcoind'
      node.set['bitcoind']['group'] = 'bitcoind'
    end.converge(described_recipe)
  end

  # Ensure that config_merged was created
  it 'creates user' do
    expect(chef_run).to create_user('bitcoind').with(username: 'bitcoind')
  end

  # Write quick specs using `it` blocks with implied subjects
  #node['base']['users'].each do |username, fullname|
  #  it { should create_user(username).with(username: username) }
  #end

  # Write full examples using the `expect` syntax
  #it 'creates users' do
  #  node['base']['users'].each do |username, fullname|
  #    expect(subject).to create_user(username)
  #  end
  #end

  # Use an explicit subject
  #let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  #it 'does something' do
  #  expect(chef_run).to do_something('...')
  #end
end
