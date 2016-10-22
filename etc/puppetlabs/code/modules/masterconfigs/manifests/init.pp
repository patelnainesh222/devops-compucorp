#Packages required for the drupal setup for CompuCorp
#

class masterconfigs {
	#include manifests/*.pp;
	require masterconfigs::yumupdate
	require masterconfigs::repoconfig
	require masterconfigs::drupalpackages
	require masterconfigs::nginxsetup

        #configure mysql
        #class { '::mysql::server':
        #  package_name     => 'mariadb-server',
        #  root_password           => 'Abcd123$',
        #  remove_default_accounts => true,
         # override_options        => $override_options
       # }

	include masterconfigs::mysqlsetup
	require masterconfigs::drupalcore
	require masterconfigs::drupalapp
	require masterconfigs::civicrm
	require masterconfigs::civicrmapp
}
