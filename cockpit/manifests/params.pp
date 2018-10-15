# cockpit::params - Default parameters
class cockpit::params {
 
 # OS Specific Defaults
  case $::osfamily {
    'RedHat': {
      $yum_preview_repo = false
      $manage_kdump_conf = true
    }
    'Debian': {
      $yum_preview_repo = undef
      $manage_kdump_conf = false
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
 
  # Defaults for all Operating Systems
  # (Cockpit has consistant naming accross OS's, hooray! :D)
  $allowunencrypted     = false
  $logintitle           = $::fqdn
  $manage_package       = true
  $manage_repo          = true
  $manage_service       = true
  $maxstartups          = '10'
  $package_name         = ['cockpit', 'cockpit-bridge', 'cockpit-dashboard', 'cockpit-doc', 'cockpit-ws', 'cockpit-docker', 'cockpit-kubernetes', 'cockpit-machines', 'cockpit-machines-ovirt.noarch', 'cockpit-packagekit', 'cockpit-pcp', 'cockpit-selinux.noarch', 'setroubleshoot', 'setools', 'cockpit-storaged.noarch', 'cockpit-tests','sos', 'subscription-manager-cockpit.noarch']
  $package_version      = 'installed'
  $port                 = undef
  $service_ensure       = 'running'
  $service_enable       = true
  $service_name         =  ['cockpit.socket']
  $manage_kdump_service = true
  $kdump_service_name   = 'kdump'
  $kdump_service_ensure = 'running'
  $kdump_service_enable = true
}
