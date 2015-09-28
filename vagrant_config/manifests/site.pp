class misc {

  exec { "grap-epel":
    command => "/bin/rpm -Uvh https://mirror.webtatic.com/yum/el7/epel-release.rpm",
    creates => "/etc/yum.repos.d/epel.repo",
    alias   => "grab-epel",
  }

  exec { "grab-webtatic":
    command => "/bin/rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm",
    alias   => "grab-webtatic"
  }

}

class httpd {

  exec { 'yum-update':
    command => '/usr/bin/yum -y update'
  }

  package { "httpd":
    ensure => present
  }

  package { "httpd-devel":
    ensure  => present
  }

  service { "httpd":
    ensure => "running",
    require => Package["httpd"]
  }

  file { "/etc/httpd/conf.d/symfony.conf":
    ensure => "link",
    target => "/var/www/symfony/vagrant_config/config/vhost.conf",
    require => Package["httpd"],
    notify => Service["httpd"],
    replace => yes,
    force => true,
  }

}

class phpdev {

  package { "libxml2-devel":
  ensure  => present,
  }


  package { "libXpm-devel":
  ensure  => present,
  }

  package { "gmp-devel":
  ensure  => present,
  }

  package { "libicu-devel":
  ensure  => present,
  }

  package { "t1lib-devel":
  ensure  => present,
  }

  package { "aspell-devel":
  ensure  => present,
  }

  package { "openssl-devel":
  ensure  => present,
  }

  package { "bzip2-devel":
  ensure  => present,
  }

  package { "libcurl-devel":
  ensure  => present,
  }

  package { "libjpeg-turbo-devel":
  ensure  => present,
  }

  package { "libvpx-devel":
  ensure  => present,
  }

  package { "libpng-devel":
  ensure  => present,
  }

  package { "freetype-devel":
  ensure  => present,
  }

  package { "readline-devel":
  ensure  => present,
  }

  package { "libtidy-devel":
  ensure  => present,
  }

  package { "libxslt-devel":
  ensure  => present,
  }
}

class mysql {

  package { "mariadb-server":
    ensure  => present,
  }

  package { "mariadb":
    ensure  => present,
  }

  service { "mariadb":
    ensure => running, 
    require => Package["mariadb-server"]
  }

}

class php {

  package { "php56w":
    ensure  => present,
    require => Exec["grab-webtatic"]
  }

  package { "php56w-cli":
    ensure  => present,
    require => Exec["grab-webtatic"]
  }

  package { "php56w-common":
    ensure  => present,
    require => Exec["grab-webtatic"]
  }

  package { "php56w-devel":
    ensure  => present,
    require => Exec["grab-webtatic"]
  }

  package { "php56w-gd":
    ensure  => present,
    require => Exec["grab-webtatic"]
  }

  package { "php56w-mcrypt":
    ensure  => present,
    require => Exec["grab-webtatic"]
  }

  package { "php56w-intl":
    ensure  => present,
    require => Exec["grab-webtatic"]
  }

  package { "php56w-ldap":
    ensure  => present,
    require => Exec["grab-webtatic"]
  }

  package { "php56w-mbstring":
    ensure  => present,
    require => Exec["grab-webtatic"]
  }

  package { "php56w-mysql":
    ensure  => present,
    require => Exec["grab-webtatic"]
  }

  package { "php56w-pdo":
    ensure  => present,
    require => Exec["grab-webtatic"]
  }

  package { "php56w-pear":
    ensure  => present,
    require => Exec["grab-webtatic"]
  }

  package { "php56w-soap":
    ensure  => present,
    require => Exec["grab-webtatic"]
  }

  package { "php56w-xml":
    ensure  => present,
    require => Exec["grab-webtatic"]
  }
  
}

include misc
include httpd
include phpdev
include mysql
include php
