        class masterconfigs::civicrm {
          $civicrm_version = '4.7.12'

          file { '/opt/civicrm': 
		ensure => directory,
		require => Exec['drupal-additional-config'],
		}

          exec { 'get-civicrm':
            command => "/bin/wget http://downloads.sourceforge.net/project/civicrm/civicrm-stable/4.7.12/civicrm-${civicrm_version}-drupal.tar.gz -P /opt/civicrm",
            creates => "/opt/civicrm/civicrm-${civicrm_version}-drupal.tar.gz",
            require => File['/opt/civicrm'],
          }

          file { '/usr/share/drush/commands/civicrm.drush.inc':
            ensure  => present,
            mode    => '755',
            source  => 'puppet:///modules/masterconfigs/civicrm.drush.inc',
            require => Exec['get-civicrm'],
          }

        exec { 'drush-civicrm-setup' :
                command => "/bin/drush civicrm-install --dbuser=civicrm --dbpass=Abcd123$ --dbhost=localhost --dbname=civicrm --tarfile=/opt/civicrm/civicrm-${civicrm_version}-drupal.tar.gz --destination=sites/all/modules",
		cwd => '/usr/share/nginx/drupal',
                creates => "/usr/share/nginx/drupal/sites/all/modules/civicrm",
		require => File['/usr/share/drush/commands/civicrm.drush.inc'],
	}

	exec {'civicrm-enable' :
		command => "/bin/drush pm-enable civicrm -y;/bin/chmod -R 777 sites/default/",
		cwd => '/usr/share/nginx/drupal',
		require => Exec['drush-civicrm-setup'],
	}
}
