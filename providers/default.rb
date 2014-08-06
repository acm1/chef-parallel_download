def whyrun_supported?
  true
end

action :download do
  to_download = check_checksums
  if download_required? to_download
    converge_by "download #{@new_resource.name}" do
      download_files to_download
    end
    new_resource.updated_by_last_action(true)
  end
end

def download_files(files)
  temp_dir = Dir.mktmpdir

  scripts = files.map do |k, v|
    make_download_script(k, v, temp_dir)
  end

  parallel_execute(scripts, @new_resource.max_procs)

  delete_dir temp_dir
end

def parallel_execute(scripts, max_procs)
  cmd = Mixlib::ShellOut.new("xargs -n 1 -P #{max_procs} -d '\n' sh",
                             input: scripts.join("\n"))
  cmd.run_command
  cmd.error!
end

def delete_dir(dir)
  FileUtils.rm_r dir
end

def make_download_script(k, v, temp_dir)
  temp_file = Tempfile.new('parallel', temp_dir)
  temp_file.write case URI.parse(v[:uri]).scheme
                  when 's3'
                    s3_script(k, v)
                  else
                    curl_script(k, v)
                  end
  temp_file.close
  temp_file.path
end

def curl_script(k, v)
  "curl --output '#{k}' --silent --fail --location '#{v[:uri]}'"
end

def s3_script(k, v)
  if v[:aws_access_key] && v[:aws_secret_access_key]
    <<-EOL
    export AWS_ACCESS_KEY_ID=#{v[:aws_access_key]}
    export AWS_SECRET_ACCESS_KEY=#{v[:aws_secret_access_key]}
    EOL
  else
    ''
  end +
  "aws s3 cp '#{v[:uri]}' '#{k}'"
end

def download_required?(x)
  !x.empty?
end

def check_checksums
  new_resource.files.reject { |k, v| checksums_match?(k, v) }
end

def checksums_match?(k, v)
  if ::File.exist?(k)
    checksum_ok?(k, v)
  else
    false
  end
end

def checksum_ok?(k, v)
  file_content = ::File.read k
  has_256 = v.key?(:sha256sum)
  has_md5 = v.key?(:md5sum)
  if has_256 || has_md5
    (has_256 ? sha256(file_content) == v[:sha256sum] : true) &&
    (has_md5 ? md5(file_content) == v[:md5sum] : true)
  else
    false
  end
end

def sha256(x)
  Digest::SHA256.hexdigest x
end

def md5(x)
  Digest::MD5.hexdigest x
end
