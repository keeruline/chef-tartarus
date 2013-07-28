Description
===========

Installs [tartarus](http://wiki.hetzner.de/index.php/Tartarus_Backup-Konfiguration/en) and provides a LWRP for creating backup tasks easyily within a chef run.

Requirements
============

Platform
--------

* Debian

Cookbooks
---------

* apt

Attributes
==========

* `node.default['tartarus']['databag']` - (default: `Chef::EncryptedDataBagItem.load("tartarus", "default")`)
* `node.default['tartarus']['config_path']` - (default: `/etc/tartarus`)
* `node.default['tartarus']['run_path']` - (default: `/usr/sbin`)
* `node.default['tartarus']['timestamps_path']` - (default: `/var/spool/tartarus/timestamps`)
* `node.default['tartarus']['hooks_template_cookbook']` - (default: `tartarus`)
* `node.default['tartarus']['apt_repository']['name']` - (default: `wertarbyte`)
* `node.default['tartarus']['apt_repository']['uri']` - (default: `http://wertarbyte.de/apt ./`)
* `node.default['tartarus']['apt_repository']['key']` - (default: `http://wertarbyte.de/apt/software-key.gpg`)

* `node.default['tartarus']['cron']['month']` - (default: `*`)
* `node.default['tartarus']['cron']['weekday']` - (default: `*`)
* `node.default['tartarus']['cron']['day']` - (default: `*`)
* `node.default['tartarus']['cron']['hour']` - (default: `3`)
* `node.default['tartarus']['cron']['minute']` - (default: `45`)

* `node.default['tartarus']['encrypt_passphrase']` - (default: `node['tartarus']['databag']['encrypt_passphrase']`)

* `node.default['tartarus']['incremental_backup']` - (default: `false`)
* `node.default['tartarus']['stay_in_filesystem']` - (default: `true`)
* `node.default['tartarus']['create_lvm_snapshot']` - (default: `false`)
* `node.default['tartarus']['lvm_volume_name']` - (default: `nil`)
* `node.default['tartarus']['snapshot_dir']` - (default: `nil`)
* `node.default['tartarus']['lvm_mount_options']` - (default: `nil`)
* `node.default['tartarus']['lvm_snapshot_size']` - (default: `200m`)
* `node.default['tartarus']['assembly_method']` - (default: `tar`)
* `node.default['tartarus']['tar_options']` - (default: `nil`)
* `node.default['tartarus']['compression_method']` - (default: `gzip`)
* `node.default['tartarus']['storage_method']` - (default: `SIMULATE`)
* `node.default['tartarus']['storage_file_dir']` - (default: `nil`)
* `node.default['tartarus']['storage_ftp_server']` - (default: `nil`)
* `node.default['tartarus']['storage_ftp_dir']` - (default: `nil`)
* `node.default['tartarus']['storage_ftp_user']` - (default: `nil`)
* `node.default['tartarus']['storage_ftp_password']` - (default: `nil`)
* `node.default['tartarus']['storage_ftp_use_ssl']` - (default: `false`)
* `node.default['tartarus']['storage_ftp_ssl_insecure']` - (default: `false`)
* `node.default['tartarus']['storage_ftp_use_sftp']` - (default: `false`)
* `node.default['tartarus']['storage_chunk_size']` - (default: `nil`)
* `node.default['tartarus']['incremental_stacking']` - (default: `false`)
* `node.default['tartarus']['exclude']` - (default: `nil`)
* `node.default['tartarus']['exclude_files']` - (default: `nil`)
* `node.default['tartarus']['exclude_filename_patterns']` - (default: `nil`)
* `node.default['tartarus']['encrypt_symmetrically']` - (default: `false`)
* `node.default['tartarus']['encrypt_asymmetrically']` - (default: `false`)
* `node.default['tartarus']['encrypt_key_id']` - (default: `nil`)
* `node.default['tartarus']['encrypt_keyring']` - (default: `nil`)
* `node.default['tartarus']['encrypt_gpg_options']` - (default: `nil`)
* `node.default['tartarus']['limit_disk_io']` - (default: `true`)
* `node.default['tartarus']['check_for_update']` - (default: `false`)
* `node.default['tartarus']['file_list_creation']` - (default: `false`)
* `node.default['tartarus']['file_list_directory']` - (default: `nil`)

* `node.default['tartarus']['pre_process_hook']` - (default: `pre_process_hook.erb`)
* `node.default['tartarus']['post_process_hook']` - (default: `post_process_hook.erb`)
* `node.default['tartarus']['pre_configverify_hook']` - (default: `pre_configverify_hook.erb`)
* `node.default['tartarus']['post_configverify_hook']` - (default: `post_configverify_hook.erb`)
* `node.default['tartarus']['pre_cleanup_hook']` - (default: `pre_cleanup_hook.erb`)
* `node.default['tartarus']['post_cleanup_hook']` - (default: `post_cleanup_hook.erb`)
* `node.default['tartarus']['pre_freeze_hook']` - (default: `pre_freeze_hook.erb`)
* `node.default['tartarus']['post_freeze_hook']` - (default: `post_freeze_hook.erb`)
* `node.default['tartarus']['pre_store_hook']` - (default: `pre_store_hook.erb`)
* `node.default['tartarus']['post_store_hook']` - (default: `post_store_hook.erb`)
* `node.default['tartarus']['debug_hook']` - (default: `debug_hook.erb`)
* `node.default['tartarus']['pre_find_hook']` - (default: `pre_find_hook.erb`)
* `node.default['tartarus']['post_find_hook']` - (default: `post_find_hook.erb`)
* `node.default['tartarus']['pre_tar_hook']` - (default: `pre_tar_hook.erb`)
* `node.default['tartarus']['pre_compression_hook']` - (default: `pre_compression_hook.erb`)
* `node.default['tartarus']['post_compression_hook']` - (default: `post_compression_hook.erb`)
* `node.default['tartarus']['pre_storage_hook']` - (default: `pre_storage_hook.erb`)
* `node.default['tartarus']['post_storage_hook']` - (default: `post_storage_hook.erb`)


Usage
=====

Simply include the recipe where you want the lwrp to be used.
Note that you must define sensitive data in a encrypted databag called `tartarus/default`

LWRP
=====

The cookbook provides access to an LWRP (Leightweight Resource and Provider) which can be used to generate backup tasks with tartarus. All attributes are derived from their original names. Default attribute values (set by node attributes) can be overriden using the lwrp directive.

Example:
```ruby
tartarus "NAME_OF_PROFILE" do
	directory "/PATH/TO/BACKUP"
	action :add
end
````

Process hooks are implemented as chef template partials (see templates/default/ for hook files). You may include shell functions inside those .erb-files and simply activate it using e.g. `node.default['tartarus']['pre_process_hook'] = 'pre_process_hook.erb'`. You may use template files located in another cookbook by setting ``node.default['tartarus']['hooks_template_cookbook']``.

License and Author
==================

Author:: Achim Rosenhagen (<a.rosenhagen@ffuenf.de>)

Copyright:: 2013, Achim Rosenhagen

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
