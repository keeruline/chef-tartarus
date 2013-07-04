maintainer       "Achim Rosenhagen"
maintainer_email "a.rosenhagen@ffuenf.de"
license          "Apache 2.0"
description      "installs/configures tartarus"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

%w{ debian }.each do |os|
	supports os
end

%w{ apt ssh_known_hosts }.each do |ressource|
	depends ressource
end

