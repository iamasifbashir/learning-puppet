class pasture (

  $port                 = '80',
  $default_character    = 'dragon',
  $default_message      = 'Puppet Can Save Your Company Millions',
  $pasture_config_file  = '/etc/pasture_config.yaml',
) {

  include pasture::base

  package { 'pasture':
    ensure   => 'present',
    provider => 'gem',
    before   => [File[$pasture_config_file],
                File['/etc/systemd/system/pasture.service']]
  }

  $pasture_config_params = {
    'port'              =>  $port,
    'default_animal'    =>  $default_character,
    'default_message'   =>  $default_message
  }

  file { $pasture_config_file:
    content => epp('pasture/pasture_config.yaml.epp', $pasture_config_params)
  }

  $pasture_service_param = {
    'pasture_config_file' => $pasture_config_file
  }

  file { '/etc/systemd/system/pasture.service':
    content => epp('pasture/pasture.service.epp', $pasture_service_param)
  }

  service { 'pasture':
    ensure    => 'running',
    subscribe => File[$pasture_config_file],
    require   => File['/etc/systemd/system/pasture.service']
  }
}
