#
# Cookbook Name:: parallel_download
# Recipe:: default
#
# Copyright (C) 2014 Bloom Health
#
# All rights reserved - Do Not Redistribute
#

package 'curl'

include_recipe 'python'
python_pip 'awscli'
