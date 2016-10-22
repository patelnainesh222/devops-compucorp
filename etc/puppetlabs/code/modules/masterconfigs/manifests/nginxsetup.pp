class masterconfigs::nginxsetup {

        service { 'php-fpm':
          name      => php-fpm,
          ensure    => running,
          enable    => true,
	  require => Package['php-fpm'],
        }

        file { 'nginx.conf':
          path    => '/etc/nginx/nginx.conf',
          ensure  => file,
          source  => "puppet:///modules/masterconfigs/nginx.conf",
	  require => Package['nginx'],
        }
          exec { 'change-hostname-nginx':
            	command => "/bin/sed -i 's/hostname/`/bin/curl -s http://169.254.169.254/latest/meta-data/public-hostname`/g' /etc/nginx/nginx.conf",
                require => File['nginx.conf'],
          }

          file { '/etc/nginx/ssl':
            ensure  => directory,
            mode    => '600',
	    require => Package['nginx'],
          }

          exec { 'generate-ssl-certs':
            command => "/bin/openssl req -subj '/CN=`curl -s http://169.254.169.254/latest/meta-data/public-hostname`/O=CompuCorp/C=UK' -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx-selfsigned.key -out /etc/nginx/ssl/nginx-selfsigned.crt;openssl dhparam -out /etc/nginx/ssl/dhparam4096.pem 4096",
            cwd => "/etc/nginx/ssl",
		require => File['/etc/nginx/ssl'],
          }

        #configure nginx
        service { 'nginx':
          name      => nginx,
          ensure    => running,
          enable    => true,
	  require => Package['nginx'],
        }

}
