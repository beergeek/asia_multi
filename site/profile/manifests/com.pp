class profile::com {

  $enable_firewall = hiera('profile::com::enable_firewall',true)

  if $enable_firewall {
    Firewall {
      before  => Class['profile::fw::post'],
      require => Class['profile::fw::pre'],
    }

    firewall { '100 allow puppet access':
      dport  => [8140],
      proto  => tcp,
      action => accept,
    }

    firewall { '100 allow mco access':
      dport  => [61613],
      proto  => tcp,
      action => accept,
    }

    firewall { '100 allow amq access':
      dport  => [61616],
      proto  => tcp,
      action => accept,
    }
  }

  @@haproxy::balancermember { "master00-${::fqdn}":
    listening_service => "puppet00-${trusted['extensions']['pp_datacenter']}",
    server_names      => $::fqdn,
    ipaddresses       => $::ipaddress_enp0s8,
    ports             => '8140',
    options           => 'check',
  }
  @@haproxy::balancermember { "mco00-${::fqdn}":
    listening_service => "mco00-${trusted['extensions']['pp_datacenter']}",
    server_names      => $::fqdn,
    ipaddresses       => $::ipaddress_enp0s8,
    ports             => '61613',
    options           => 'check',
  }

}
