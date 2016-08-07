require 'spec_helper'

describe 'tomcat::default' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  describe command('curl http://localhost:8080') do
    its(:stdout) { should match /Tomcat/ }

  end

  describe package('java-1.7.0-openjdk-devel') do
      it { should be_installed }
    end

  describe group('tomcat') do
    it { should exist }
  end

  describe user('tomcat') do
    it { should belong_to_group 'tomcat' }
    it { should have_home_directory '/opt/tomcat'}
  end

  describe user('tomcat') do
    it { should have_login_shell '/bin/nologin' }
  end

  describe file('/opt/tomcat') do
    it { should be_directory }
  end

  describe file('/root/apache-tomcat-8.5.4.tar.gz') do
    it { should be_file }
  end

  describe file("/opt/tomcat/conf") do
    it { should be_grouped_into 'tomcat' }
  end

  # describe file('/opt/tomcat/conf/*') do
  #   it { should be_readable.by('group') }
  #   it { should be_executable.by('group') }
  #   it { should be_writable.by('group') }
  # end

#webapps/ work/ temp/ logs/
  %w[webapps work temp logs bin lib].each do |path|
  describe file("/opt/tomcat/#{path}") do
    it {should be_owned_by 'tomcat'}
    end
  end

describe file("/etc/systemd/system/tomcat.service") do
  it {should exist}
end

end
