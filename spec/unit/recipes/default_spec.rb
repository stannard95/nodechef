#
# Cookbook:: node-server
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'node-server::default' do
  context 'When all attributes are default, on an Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'install nginx' do
      expect(chef_run).to install_package 'nginx'
    end

    it 'enable the nginx service' do
      expect(chef_run).to enable_service 'nginx'
    end

    it 'start the nginx service' do
      expect(chef_run).to start_service 'nginx'
    end

    it 'downloads the nodejs installer' do
        expect(chef_run).to create_remote_file('/tmp/node_installer').with(source: 'https://deb.nodesource.com/setup_6.x')
    end

    it 'runs the node installer' do 
      expect(chef_run).to run_execute('sh /tmp/node_installer')
    end

    it 'installs pm2 with npm' do 
      expect(chef_run).to run_execute('npm install pm2 -g')
    end

    it 'install nodejs' do
      expect(chef_run).to upgrade_package 'nodejs'
    end
  end
end
