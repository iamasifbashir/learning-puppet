class cowsay::cowsay {
    package { 'cowsay':
        ensure => 'present',
        provider => 'gem'
    }
}
