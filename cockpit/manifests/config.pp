# cockpit::config - Used for managing config files for a cockpit and kdump
#
class cockpit::config {
  ini_setting { 'Cockpit LoginTitle':
    ensure    => present,
    path      => '/etc/cockpit/cockpit.conf',
    section   => 'WebService',
    setting   => 'LoginTitle',
    value     => $::cockpit::logintitle,
    show_diff => true,
  }

  ini_setting { 'Cockpit MaxStartups':
    ensure    => present,
    path      => '/etc/cockpit/cockpit.conf',
    section   => 'WebService',
    setting   => 'MaxStartups',
    value     => $::cockpit::maxstartups,
    show_diff => true,
  }

  ini_setting { 'Cockpit AllowUnencrypted':
    ensure    => present,
    path      => '/etc/cockpit/cockpit.conf',
    section   => 'WebService',
    setting   => 'AllowUnencrypted',
    value     => $::cockpit::allowunencrypted,
    show_diff => true,
  }

  if $::cockpit::port {
    file { '/etc/systemd/system/cockpit.socket.d/':
      ensure => directory,
      owner  => 'root',
      group  => 'root',
    }
    ->
    file { '/etc/systemd/system/cockpit.socket.d/listen.conf':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      content => template('cockpit/etc/systemd/system/cockpit.socket.d/listen.conf.erb'),
    }
    ~>
    exec { 'Cockpit systemctl daemon-reload':
      command     => 'systemctl daemon-reload',
      refreshonly => true,
      path        => $::path,
    }
 }

 if $::cockpit::manage_kdump_conf {
    file { '/etc/default/grub':
      ensure => present,
    }->
    file_line { 'replace a value to /etc/default/grub':
      path   => '/etc/default/grub',
      line   => 'GRUB_CMDLINE_LINUX="crashkernel=128M rd.lvm.lv=centos/root rd.lvm.lv=centos/swap rhgb quiet"',
      match  => '^GRUB_CMDLINE_LINUX="crashkernel=auto',

    }
    exec { 'config write':
      command     => 'grub2-mkconfig > /boot/grub2/grub.cfg', 
      path        => '/usr/bin:/usr/sbin:/bin:/sbin',
      refreshonly => true,
      subscribe   => File_line['replace a value to /etc/default/grub'],
    }
  }
}
