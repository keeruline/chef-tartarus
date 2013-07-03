# # # # # # #
# tartarus  #
# # # # # # #
node.set['tartarus']['databag'] = Chef::EncryptedDataBagItem.load("tartarus", "tartarus")
node.set['tartarus']['config_path'] = "/etc/tartarus"

node.set['tartarus']['ENCRYPT_PASSPHRASE'] = node['tartarus']['databag']['ENCRYPT_PASSPHRASE']

node.set['tartarus']['STORAGE_FTP_SERVER'] = node['tartarus']['databag']['STORAGE_FTP_SERVER']
node.set['tartarus']['STORAGE_FTP_USER'] = node['tartarus']['databag']['STORAGE_FTP_USER']
node.set['tartarus']['STORAGE_FTP_PASSWORD'] = node['tartarus']['databag']['STORAGE_FTP_PASSWORD']
node.set['tartarus']['STORAGE_FTP_USE_SFTP'] = "yes"
node.set['tartarus']['COMPRESSION_METHOD'] = "gzip"
node.set['tartarus']['LVM_SNAPSHOT_SIZE'] = "100M"
node.set['tartarus']['ENCRYPT_SYMMETRICALLY'] = "yes"
node.set['tartarus']['ENCRYPT_PASSPHRASE_FILE'] = "#{node['tartarus']['config_path']}/backup.sec"
node.set['tartarus']['STAY_IN_FILESYSTEM'] = "yes"

node.set['tartarus']['backups'] = [
	{
		"name" => "",
		"directory" => ""
	}
]
