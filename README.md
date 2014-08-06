# parallel_download-cookbook

Provides the `parallel_download` resource to download multiple files at once.

## Supported Platforms

* Ubuntu 12.04 LTS
* Ubuntu 14.04 LTS

## Attributes

* `node['parallel_download']['max_procs']`: Max number of process to run at once. Default: 8

## Usage

Include the `recipe[parallel_download::default]` in your run_list to ensure the pre-reqs for the `parallel_download` resource are installed.

## parallel_download resource

### Attributes

* `files`: a Hash describing files to download and where to download them to.
The Hash keys are strings containing the full destination path of the file.
Each key value is a hash containing, at a minimum, the key `:uri`, with a string value
of the http:// or s3:// uri to download from. The key keys `:md5sum` or `:sha256sum` may
be set to give a hash which will be checked against the existing file before downloading.
The `:aws_access_key` and `:aws_secret_access_key` keys may be set if downloading from
an S3 URI. If they are not set, IAM role credentials will be used. See below for a
usage example.

* `max_procs`: (optional) the maximum number of parallel download processes to run simultaneously.
The default is `node['parallel_download']['max_procs']`, which defaults to 8.

### Example

```
parallel_download 'somefiles' do
  files(
    '/path/to/file1.tgz' => {
      uri: 'http://user:pass@mydomain.com/path/to/file1.tgz',
      sha256sum: 'abc123456'
    },
    '/other/path/to/file2.tgz' => {
      uri: 's3://my-bucket/file2.tgz',
      md5sum: '123456abcdef',
      aws_access_key: 'ABCDEFGHIJKLMNOP',
      aws_secret_access_key: 'mysecretaccess+key'
    }
  )
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Bloom Health (<amielke@bloomhealth.com>)
