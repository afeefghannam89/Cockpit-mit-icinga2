# cockpit::repo - Used for managing the cockpit and kdump service
#
class cockpit::service {

  if $::cockpit::manage_service {
    service { $::cockpit::service_name:
      ensure => $::cockpit::service_ensure,
      enable => $::cockpit::service_enable,
    }
  }
  if $::cockpit::manage_kdump_service {
    service { $::cockpit::kdump_service_name:
      ensure => $::cockpit::kdump_service_ensure,
      enable => $::cockpit::kdump_service_enable,
  }
 }
}
