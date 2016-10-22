        class masterconfigs::civicrm {
          $civicrm_version = '4.7.12'

          file { '/opt/civicrm': ensure => directory, 
		require => Exec['copy-app'],	}

          exec { 'get-civicrm':
            command => "/bin/wget http://downloads.sourceforge.net/project/civicrm/civicrm-stable/4.7.12/civicrm-${civicrm_version}-drupal.tar.gz -P /opt/civicrm",
            creates => "/opt/civicrm/civicrm-${civicrm_version}.tar.gz",
            require => File['/opt/civicrm'],
          }

          exec { 'uncompress-civicrm':
            command => "/bin/tar -xzf /opt/civicrm/civicrm-${civicrm_version}.tar.gz -C /opt/civicrm",
            creates => "/opt/civicrm/civicrm-${civicrm_version}",
            require => Exec['get-civicrm'],
          }

          file { '/opt/civicrm/current':
            ensure  => link,
            target  => "/opt/civicrm/civicrm-${civicrm_version}",
            require => Exec['uncompress-civicrm']
          }
        }
