class masterconfigs::mysqlsetup {

        #configure mysql
        #class { '::mysql::server':
        #  package_name     => 'mariadb-server',
        #  root_password           => 'Abcd123$',
        #  remove_default_accounts => true,
        # # override_options        => $override_options
        #}

        service { 'mariadb':
          name      => mariadb,
          ensure    => running,
          enable    => true,
	  #before => File['/opt/drupalcore'],
	  require => Service['nginx'],
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
        }

        #grant select on civicrm to drupal
        mysql_grant { 'drupal@localhost/civicrm.*':
          ensure     => 'present',
          options    => ['GRANT'],
          privileges => ['SELECT'],
          table      => 'civicrm.*',
          user       => 'drupal@localhost',
	  require => Service['mariadb'],
        }

}
