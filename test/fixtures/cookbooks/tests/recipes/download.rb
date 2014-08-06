include_recipe 'parallel_download'

parallel_download 'sample-files' do
  files(
    '/tmp/tmux-1.8.tar.gz' => {
      uri: 'http://downloads.sourceforge.net/project/tmux/tmux/tmux-1.8/tmux-1.8.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Ftmux%2Ffiles%2Ftmux%2Ftmux-1.8%2F&ts=1407352541&use_mirror=iweb',
      md5sum: 'b9477de2fe660244cbc6e6d7e668ea0e'
    },
    '/tmp/curl-7.37.1.tar.gz2' => {
      uri: 'http://curl.haxx.se/download/curl-7.37.1.tar.bz2',
      sha256sum: 'c3ef3cd148f3778ddbefb344117d7829db60656efe1031f9e3065fc0faa25136'
    },
    '/tmp/boot2docker.iso' => {
      uri: 'https://github.com/boot2docker/boot2docker/releases/download/v.1.1.2/boot2docker.iso',
      sha256sum: '431c41089782676190476b36d614c9ac32c4f3221b0a61e1b6813d6102d18d50'
    },
    '/tmp/chef-11.14.2-1.dmg' => {
      uri: 's3://opscode-omnibus-packages/mac_os_x/10.7/x86_64/chef-11.14.2-1.dmg',
      sha256sum: '707d62e65ca8803a621705dda854e681ebd1363708ce1f8163c602d58e1bb507',
      aws_access_key: node['tests']['aws_access_key'],
      aws_secret_access_key: node['tests']['aws_secret_access_key']
    }
  )
end
