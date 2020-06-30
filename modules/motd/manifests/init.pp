# Class: motd
#
#
class motd {

  file { '/etc/motd':
    content => epp('/motd/motd.epp')
  }
}
