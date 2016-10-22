class masterconfigs::drupalapp {
          exec { 'copy-app':
            command => '/bin/cp -r /opt/drupalcore/current/ /usr/share/nginx/drupal',
            creates => '/usr/share/nginx/drupal',
	   require => Exec['get-drupal'],
          }

          exec { 'copy-drupal-settings':
            command => '/bin/cp /usr/share/nginx/drupal/sites/default/default.settings.php /usr/share/nginx/drupal/sites/default/settings.php',
            creates => '/usr/share/nginx/drupal/sites/default/settings.php',
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

          exec { 'drupal-permissions':
            command => '/bin/chmod -R 777 /usr/share/nginx/drupal/sites/default/;/bin/chown -hR apache:apache /usr/share/nginx/drupal;restorecon -R /usr/share/nginx/drupal;chcon -R -h -t httpd_sys_script_rw_t /usr/share/nginx/drupal/sites/default/;chcon -R -h -t httpd_sys_script_rw_t /usr/share/nginx/private;',
		require => Exec['copy-drupal-settings'],
          }

	exec { 'drush-settings':
		command => "/bin/drush -y site-install standard --db-url='mysql://drupal:Abcd123$@localhost/drupal' --site-name=Example --account-name=admin --account-pass='password';drush vset --yes file_private_path ../private;",
		cwd => '/usr/share/nginx/drupal',
	   require => Exec['copy-app'],
	}
          file { '/opt/drupal-additional.config':
            ensure  => present,
            mode    => '755',
            source  => 'puppet:///modules/masterconfigs/drupal-additional.config',
            require => Exec['drush-settings'],
          }

	exec { 'drupal-additional-config' :
		command => "/bin/cat /opt/drupal-additional.config >> /usr/share/nginx/drupal/sites/default/settings.php;",
		require => File['/opt/drupal-additional.config'],
	}
}
