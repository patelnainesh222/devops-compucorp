# = Class: drush::drush
#
# == Parameters:
#
# [*verion*]
#   The version of drush to install.
#
# [*target_dir*]
#   Where to install the drush package.
#
# [*link_name*]
#   The full path for the drush symlink.
#
# [*user*]
#   The owner of the drush directory.
#
# == Example:
#
#   include drush::drush
#
#   class { 'drush::drush':
#     'version'    => '7',
#     'target_dir' => '/opt',
#     'link_name'  => '/usr/local/bin/drush',
#     'user'       => 'root',
#   }
#
define drush::drush (
  $version    = hiera('drush::version',    '7'),
  $target_dir = hiera('drush::target_dir', '/opt'),
  $link_name  = hiera('drush::link_name',  '/usr/local/bin/drush'),
  $user       = hiera('drush::user',       'root'),
) {

  # Make sure that the target dir exists and is writable by the user.
  file { "${target_dir}/drush-${version}":
    ensure => directory,
    owner  => $user,
    mode   => '0755'
  }

  # Grab drush via composer.
  exec { "drush-install-${version}":
    command     => "composer --prefer-dist require drush/drush ${version}",
    path        => '/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin',
    cwd         => "${target_dir}/drush-${version}",
    environment => "COMPOSER_HOME=${target_dir}/drush-${version}",
    onlyif      => "test ! -f ${target_dir}/drush-${version}/vendor/bin/drush",
    user        => $user,
    require     => [
      Class['composer']
    ]
  }

  # Create a symlink.
  file { $link_name:
    ensure  => link,
    owner   => $user,
    target  => "${target_dir}/drush-${version}/vendor/bin/drush",
    require => Exec["drush-install-${version}"]
  }
}
