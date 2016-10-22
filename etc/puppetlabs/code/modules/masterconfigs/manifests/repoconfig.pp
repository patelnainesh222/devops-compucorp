class masterconfigs::repoconfig {

        file { 'epel-repo':
          path    => '/etc/yum.repos.d/epel.repo',
          ensure  => file,
          source  => "puppet:///modules/masterconfigs/epel.repo",
	 require => Exec['yum update'],
        }
        file { 'remi-repo':
          path    => '/etc/yum.repos.d/remi.repo',
          ensure  => file,
          source  => "puppet:///modules/masterconfigs/remi.repo",
	require => Exec['yum update'],
        }
}
