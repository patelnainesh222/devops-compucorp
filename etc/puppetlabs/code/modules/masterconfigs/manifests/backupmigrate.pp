        class masterconfigs::backupmigrate {
	exec { 'backupmigrate-download' :
		command => "/bin/drush pm-download --yes backup_migrate",
		cwd => '/usr/share/nginx/drupal',
		require => Exec['drupal-additional-config'],
		}

          file { '/opt/amazon-s3-php-class.tar.gz':
            ensure  => present,
            mode    => '755',
            source  => 'puppet:///modules/masterconfigs/amazon-s3-php-class.tar.gz',
            require => Exec['backupmigrate-download'],
          }

	exec { 'backupmigrate-amazons3-php-library' :
		command => "/bin/tar -xzf /opt/amazon-s3-php-class.tar.gz",
		cwd => '/usr/share/nginx/drupal/sites/all/libraries',
		require => File['/opt/amazon-s3-php-class.tar.gz'],
	}

        exec { 'backupmigrate-amazons3-php-library-rename' :
                command => "/bin/mv tpyo-amazon-s3-php-class-9cf2eec s3-php5-curl",
                cwd => '/usr/share/nginx/drupal/sites/all/libraries',
                require => Exec['backupmigrate-amazons3-php-library'],
        }

        exec { 'backupmigrate-enable' :
                command => "/bin/drush pm-enable --yes backup_migrate;/bin/chown -hR apache:apache *",
                cwd => '/usr/share/nginx/drupal',
		require => Exec['backupmigrate-amazons3-php-library-rename'],
                }

        }
