class profile::mom {

  $enable_firewall      = hiera('profile::mom::enable_firewall',true)

  Firewall {
    proto  => tcp,
    action => accept,
    before  => Class['profile::fw::post'],
    require => Class['profile::fw::pre'],
  }

  if $enable_firewall {
    firewall { '100 allow puppet access':
      dport   => [8140],
    }

    firewall { '100 allow pcp access':
      dport   => [8142],
    }

    firewall { '100 allow pcp client access':
      dport   => [8143],
    }

    firewall { '100 allow mco access':
      dport   => [61613],
    }

    firewall { '100 allow amq access':
      dport   => [61616],
    }

    firewall { '100 allow console access':
      dport   => [443],
    }

    firewall { '100 allow nc access':
      dport   => [4433],
    }

    firewall { '100 allow puppetdb access':
      dport   => [8081],
    }
  }
}
