class masterconfigs::drupalapp {
          exec { 'copy-app':
            #command => '/bin/cp -r /etc/puppet/modules/drupalstack/files/drupal /var/www/drupal',
            command => '/bin/cp -r /opt/drupalcore/current /usr/share/nginx/drupal',
            creates => '/usr/share/nginx/drupal',
	   require => Exec['get-drupal'],
          }

          file { '/usr/share/nginx/drupal/sites/default/settings.php':
            ensure  => present,
            mode    => '777',
            #source  => 'file:///var/www/drupal/sites/default/default.settings.php',
            source  => 'puppet:///modules/masterconfigs/default.settings.php',
            require => Exec['copy-app'],
          }

          file { '/usr/share/nginx/drupal/sites/default/files':
            ensure  => directory,
            mode    => '777',
            require => Exec['copy-app'],
          }
          file { '/usr/share/nginx/private':
            ensure  => directory,
            mode    => '777',
            require => Exec['copy-app'],
          }

          exec { 'drupal=permissions':
            command => '/bin/chown -hR apache:apache /usr/share/nginx/drupal;restorecon -vR /usr/share/nginx/drupal;chcon -R -h -t httpd_sys_script_rw_t /usr/share/nginx/drupal/sites/default/;chcon -R -h -t httpd_sys_script_rw_t /usr/share/nginx/private;',
            creates => '/usr/share/nginx/drupal',
          }

        }

