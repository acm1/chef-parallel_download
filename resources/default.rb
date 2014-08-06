actions :download
default_action :download

attribute :name, kind_of: String, name_attribute: true
attribute :files, kind_of: Hash, required: true
attribute :max_procs, kind_of: Integer, required: false, default: node['parallel_download']['max_procs']
