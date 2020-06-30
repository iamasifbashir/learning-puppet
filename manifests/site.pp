node 'puppet.globomantics.loc' {
  include motd
}

node 'centos-pasture.globomantics.loc' {
  include motd
  class { 'pasture':
    default_message   => 'Happy Eid',
    port              => '999',
    default_character => 'koala',
  }
}
