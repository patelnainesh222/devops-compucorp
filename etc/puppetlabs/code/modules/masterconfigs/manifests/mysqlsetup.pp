class masterconfigs::mysqlsetup {

        #configure mysql
        #class { '::mysql::server':
        #  package_name     => 'mariadb-server',
        #  root_password           => 'Abcd123$',
        #  remove_default_accounts => true,
        # # override_options        => $override_options
        #}


        package { 'mariadb-server': 
		ensure => 'installed',
		require => Service['nginx'],
                }

        service { 'mariadb':
          name      => mariadb,
          ensure    => running,
          enable    => true,
	  require => Package['mariadb-server'],
        }

        #create drupal database
        mysql::db { 'drupal':
          user     => 'drupal',
          password => 'Abcd123$',
          host     => 'localhost',
          grant    => ['ALL'],
          charset => 'utf8',
          collate => 'utf8_general_ci',
	  require => Service['mariadb'],
	  before => File['/opt/drupalcore'],
        }

        #create civicrm database
        mysql::db { 'civicrm':
          user     => 'civicrm',
          password => 'Abcd123$',
          host     => 'localhost',
          grant    => ['ALL'],
          charset => 'utf8',
          collate => 'utf8_general_ci',
	  require => Service['mariadb'],
	  before => File['/opt/civicrm'],
        }

        #grant select on civicrm to drupal
        mysql_grant { 'drupal@localhost/civicrm.*':
          ensure     => 'present',
          options    => ['GRANT'],
          privileges => ['SELECT'],
          table      => 'civicrm.*',
          user       => 'drupal@localhost',
	  require => Service['mariadb'],
	  before => File['/opt/civicrm'],
        }

}
