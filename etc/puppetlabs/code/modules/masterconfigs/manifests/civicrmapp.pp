        class masterconfigs::civicrmapp {
          exec { 'copy-civicrm-app':
            command => '/bin/cp -r /opt/civicrm/current /usr/share/nginx/drupal/sites/all/modules/civicrm',
            creates => '/usr/share/nginx/drupal/sites/all/modules/civicrm',
	    require => File['/opt/civicrm/current'],
          }

          file { '/usr/share/nginx/drupal/sites/default/civicrm.settings.php':
            ensure  => present,
            mode    => '777',
            source  => 'puppet:///modules/masterconfigs/civicrm.settings.php',
            require => Exec['copy-civicrm-app'],
          }

        	#change hostname in civicrm settings file
          exec { 'change-hostname-civicrm':
            command => "/bin/sed -i 's/hostname/`curl -s http://169.254.169.254/latest/meta-data/public-hostname`/g' /usr/share/nginx/drupal/sites/default/civicrm.settings.php",
	    require => File['/usr/share/nginx/drupal/sites/default/civicrm.settings.php'],
          }

        }
