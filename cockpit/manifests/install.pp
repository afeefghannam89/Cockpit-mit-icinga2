# cockpit::install - Used for managing packages for cockpit
#
class cockpit::install {

  if $::cockpit::manage_package {
    package { $::cockpit::package_name:
      ensure => $::cockpit::package_version,
      before => Exec[' cockpit port open'],
      notify => Exec[' cockpit port open'],
    }
   exec { ' cockpit port open':
   command => 'firewall-cmd --add-service=cockpit --permanent && firewall-cmd --reload',
   path    => '/usr/bin:/usr/sbin:/bin:/sbin',
   refreshonly => true,
  }
}
}
