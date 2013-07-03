# # # # # # #
# tartarus  #
# # # # # # #
node.default['tartarus']['databag'] = Chef::EncryptedDataBagItem.load("tartarus", "tartarus")
node.default['tartarus']['config_path'] = "/etc/tartarus"
node.default['tartarus']['timestamps_dir'] = "/var/spool/tartarus/timestamps/"

node.default['tartarus']['cron']['time_hour'] = 3
node.default['tartarus']['cron']['time_minute'] = 45

node.default['tartarus']['ENCRYPT_PASSPHRASE'] = node['tartarus']['databag']['ENCRYPT_PASSPHRASE']

node.default['tartarus']['STORAGE_FTP_SERVER'] = node['tartarus']['databag']['STORAGE_FTP_SERVER']
node.default['tartarus']['STORAGE_FTP_USER'] = node['tartarus']['databag']['STORAGE_FTP_USER']
node.default['tartarus']['STORAGE_FTP_PASSWORD'] = node['tartarus']['databag']['STORAGE_FTP_PASSWORD']
node.default['tartarus']['STORAGE_FTP_USE_SFTP'] = "yes"
node.default['tartarus']['COMPRESSION_METHOD'] = "gzip"
node.default['tartarus']['LVM_SNAPSHOT_SIZE'] = "100M"
node.default['tartarus']['ENCRYPT_SYMMETRICALLY'] = "yes"
node.default['tartarus']['ENCRYPT_PASSPHRASE_FILE'] = "#{node['tartarus']['config_path']}/backup.sec"
node.default['tartarus']['STAY_IN_FILESYSTEM'] = "yes"

node.default['tartarus']['backups'] = [
	{
		"name" => "",
		"directory" => ""
	}
]
