require 'spec_helper'

describe 'wp::default' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
describe command("curl http://localhost") do
  its(:stout) { should match /Wordpress/}
end


describe service('mysql-wp') do
  it {should be_running}
end


describe command('php -v') do
  its(:stout) {should match /PHP 7.0.9/}
end


end
