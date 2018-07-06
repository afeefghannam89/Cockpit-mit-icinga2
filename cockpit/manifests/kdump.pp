# class cockpit::kdump  used for managing grub config files to aktiv the kdump

class cockpit::kdump {

  if $::cockpit::manage_kdump {
    file { '/etc/default/grub':
      ensure => present,
    }->
    file_line { 'replace a value to /etc/default/grub':
      path  => '/etc/default/grub',
      line  => '128M',
      match => "^crashkernel=.*$",
    }
    file { '/boot/grub2/grub.cfg':
      ensure => present,
    }-> 
    file_line { 'replace a value to /boot/grub2/grub.cfg':
      path  => '/etc/default/grub',
      line  => '128M',
      match => "^crashkernel=.*$",
    }
}
