class profile::base {

  $enable_firewall = hiera('profile::base::enable_firewall',true)

  case $::kernel {
    'linux': {
      Firewall {
        before  => Class['profile::fw::post'],
        require => Class['profile::fw::pre'],
      }

      if $enable_firewall {
        class { 'firewall':
        }
        class {['profile::fw::pre','profile::fw::post']:
        }
      } else {
        class { 'firewall':
          ensure => stopped,
        }
      }
      @@host { $::fqdn:
        ensure        => present,
        host_aliases  => [$::hostname],
        ip            => $::ipaddress_enp0s8,
      }

      Host <<| |>>
    }
  }

}
