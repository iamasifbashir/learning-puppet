class cowsay::epel {
  package { 'epel-release':
    ensure => 'present'
  }
}
