require_relative '../../../kitchen/data/spec_helper'

describe package('curl') do
  it { should be_installed }
end

describe file('/usr/local/bin/aws') do
  it { should be_file }
  it { should be_executable }
end

describe file('/tmp/tmux-1.8.tar.gz') do
  it { should be_file }
  it { should match_md5checksum 'b9477de2fe660244cbc6e6d7e668ea0e' }
end

describe file('/tmp/curl-7.37.1.tar.gz2') do
  it { should be_file }
  it { should match_sha256checksum 'c3ef3cd148f3778ddbefb344117d7829db60656efe1031f9e3065fc0faa25136' }
end

describe file('/tmp/boot2docker.iso') do
  it { should be_file }
  it { should match_sha256checksum '431c41089782676190476b36d614c9ac32c4f3221b0a61e1b6813d6102d18d50' }
end

describe file('/tmp/chef-11.14.2-1.dmg') do
  it { should be_file }
  it { should match_sha256checksum '707d62e65ca8803a621705dda854e681ebd1363708ce1f8163c602d58e1bb507' }
end
