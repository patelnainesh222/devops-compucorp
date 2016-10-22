#Packages required for the drupal setup for CompuCorp
#

class masterconfigs {
	require masterconfigs::yumupdate
	require masterconfigs::repoconfig
	require masterconfigs::drupalpackages
	require masterconfigs::nginxsetup

	require masterconfigs::mysqlsetup
	require masterconfigs::drupalcore
	require masterconfigs::drupalapp

	require masterconfigs::civicrm
	require masterconfigs::backupmigrate
}
