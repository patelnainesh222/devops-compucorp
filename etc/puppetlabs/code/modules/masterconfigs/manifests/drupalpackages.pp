class masterconfigs::drupalpackages {
        $drupalpackages = [ 'nginx', 'php-fpm', 'php', 'php-apc', 'php-pear', 'php-cli', 'php-common', 'php-curl', 'php-gd', 'php-mysql' , 'git', 'drush']

        package { $drupalpackages: ensure => 'installed',
		require => File['remi-repo'],
		 }

}
