require 'spec_helper'

describe 'jenkins::default' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  describe package('java-1.7.0-openjdk') do
    it {should be_installed}
  end

  describe package('jenkins') do
    it {should be_installed}
  end

  describe port(8080) do
    it {should be_listening}
  end

end
