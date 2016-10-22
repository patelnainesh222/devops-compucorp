class masterconfigs::drupalcore {

          $drupal_version = '7.51'

          file { '/opt/drupalcore': ensure => directory,
		require => Service['mariadb'], }

          exec { 'get-drupal':
            command => "/bin/wget http://ftp.drupal.org/files/projects/drupal-${drupal_version}.tar.gz -P /opt/drupalcore",
            creates => "/opt/drupalcore/drupal-${drupal_version}.tar.gz",
            require => File['/opt/drupalcore'],
          }

          exec { 'uncompress-drupal':
            command => "/bin/tar -xzf /opt/drupalcore/drupal-${drupal_version}.tar.gz -C /opt/drupalcore",
            creates => "/opt/drupalcore/drupal-${drupal_version}",
            require => Exec['get-drupal'],
          }

          file { '/opt/drupalcore/current':
            ensure  => link,
            target  => "/opt/drupalcore/drupal-${drupal_version}",
            require => Exec['uncompress-drupal']
          }
}
