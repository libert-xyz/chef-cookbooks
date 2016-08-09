require 'spec_helper'

describe 'django1.8::default' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html

  describe command ('pip -V') do
    its(:stdout) { should match /pip/ }
  end

end
