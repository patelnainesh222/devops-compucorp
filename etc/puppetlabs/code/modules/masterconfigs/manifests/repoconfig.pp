class masterconfigs::repoconfig {
	file { 'gpg-epel7' :
		path => '/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7',
		ensure => file,
		source => "puppet:///modules/masterconfigs/RPM-GPG-KEY-EPEL-7",
		require => Exec['yum update'],
	}	

        file { 'gpg-remi' :
                path => '/etc/pki/rpm-gpg/RPM-GPG-KEY-remi',
                ensure => file,
                source => "puppet:///modules/masterconfigs/RPM-GPG-KEY-remi",
		require => Exec['yum update'],
        }

        file { 'epel-repo':
          path    => '/etc/yum.repos.d/epel.repo',
          ensure  => file,
          source  => "puppet:///modules/masterconfigs/epel.repo",
	require => File['gpg-epel7'],
        }
        file { 'remi-repo':
          path    => '/etc/yum.repos.d/remi.repo',
          ensure  => file,
          source  => "puppet:///modules/masterconfigs/remi.repo",
	require => File['gpg-remi'],
        }
}
