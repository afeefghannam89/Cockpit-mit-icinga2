node 'cockpit-puppet-agent2.localdomain', 'cockpit-puppet-agent3.localdomain' {
  class {'::icinga2':
    manage_repo => true,
  }
  class { '::cockpit':
    #package_version => 'purged',
    #package_name => ['cockpit'],
  }
}
 
node default {
 notify { "not configured": }
}
#hiera_include('classes')
