#
# Author::  Achim Rosenhagen (<a.rosenhagen@ffuenf.de>)
# Cookbook Name:: chef-tartarus
# Recipe:: default
#
# Copyright 2013, Achim Rosenhagen
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

apt_repository node['tartarus']['apt_repository']['name'] do
	uri node['tartarus']['apt_repository']['uri']
	key node['tartarus']['apt_repository']['key']
	action :add
end

%w{ tartarus tar bzip2 lvm2 gnupg curl }.each do |pkg|
	package pkg
end

directory node['tartarus']['config_path'] do
	recursive true
	action :create
end

directory node['tartarus']['timestamps_path'] do
	recursive true
	mode 755
	action :create
end
