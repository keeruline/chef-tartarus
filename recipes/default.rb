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

apt_repository "wertarbyte" do
	uri "http://wertarbyte.de/apt ./"
	key "http://wertarbyte.de/apt/software-key.gpg"
	action :add
end

%w{ tartarus tar bzip2 lvm2 gnupg curl }.each do |pkg|
	package pkg
end

#ssh_known_hosts_entry node['tartarus']['STORAGE_FTP_SERVER']

directory node['tartarus']['config_path']
directory node['tartarus']['timestamps_dir']

file node['tartarus']['ENCRYPT_PASSPHRASE_FILE'] do
	content node['tartarus']['ENCRYPT_PASSPHRASE']
	mode 0400
	action :create_if_missing
end

template "#{node['tartarus']['config_path']}/generic.inc" do
	source "tartarus.generic.erb"
	variables(
		:params => node
	)
	owner "root"
	group "root"
	mode 0644
end

node['tartarus']['backups'].each do |backup|
	template "#{node['tartarus']['config_path']}/#{backup['name']}.conf" do
		source "tartarus.erb"
		variables(
			:name => backup['name'],
			:directory => backup['directory']
		)
		owner "root"
		group "root"
		mode 0644
	end
end

template "/usr/sbin/run_tartarus" do
	source "tartarus.run.erb"
	variables(
		:params => node
	)
	owner "root"
	group "root"
	mode 0755
end

cron "run_tartarus_backup" do
	hour node['tartarus']['cron']['time_hour']
	minute node['tartarus']['cron']['time_minute']
	command "/usr/sbin/run_tartarus"
end