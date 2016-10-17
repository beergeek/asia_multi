class role::lb {
  require profile::base
  include profile::haproxy
}
