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

          file { '/etc/nginx/ssl':
            ensure  => directory,
            mode    => '600',
	    require => File['nginx.conf'],
          }

          exec { 'generate-ssl-certs':
            command => "/bin/cp /etc/pki/tls/certs/ca-bundle.trust.crt /etc/nginx/ssl/;/bin/openssl req -subj '/CN=ap-south-1.compute.amazonaws.com/O=CompuCorp/C=UK' -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx-selfsigned.key -out /etc/nginx/ssl/nginx-selfsigned.crt;",
            cwd => "/etc/nginx/ssl",
		require => File['/etc/nginx/ssl'],
          }

        file { 'dhparam4096.pem':
          path    => '/etc/nginx/ssl/dhparam4096.pem',
          ensure  => file,
          source  => "puppet:///modules/masterconfigs/dhparam4096.pem",
          require => Exec['generate-ssl-certs'],
        }


        #configure nginx
        service { 'nginx':
          name      => nginx,
          ensure    => running,
          enable    => true,
	  require => File['dhparam4096.pem'],
        }
}
