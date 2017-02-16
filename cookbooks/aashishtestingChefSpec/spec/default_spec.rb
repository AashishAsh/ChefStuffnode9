require 'chefspec'

describe 'vim::default' do
  let :chef_run do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04')
  end
end

it "should have default install_method 'package'" do
   chef_run.converge(described_recipe)
   expect(chef_run.node['vim']['install_method']).to eq('package')
end


