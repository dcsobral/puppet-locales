class locales {
    package { 'locales': ensure => installed }
    file { '/etc/locale.gen':
        source => [
            "puppet:///files/locales/host/locale.gen.$fqdn",
            "puppet:///files/locales/host/locale.gen.$hostname",
            "puppet:///files/locales/env/locale.gen.$environment",
            "puppet:///files/locales/locale.gen",
            "puppet:///locales/locale.gen",
        ],
        owner => 'root',
        group => 'root',
        mode => 644,
        require => Package['locales'],
    }
    file { '/etc/default/locale':
        source => [
            "puppet:///files/locales/host/default/locale.$fqdn",
            "puppet:///files/locales/host/default/locale.$hostname",
            "puppet:///files/locales/env/default/locale.$environment",
            "puppet:///files/locales/default/locale",
            "puppet:///locales/default/locale",
        ],
        owner => 'root',
        group => 'root',
        mode => 644,
        require => Package['locales'],
    }
    exec { '/usr/sbin/locale-gen':
        subscribe => File['/etc/locale.gen'],
        refreshonly => true,
        require => [ Package['locales'], File['/etc/locale.gen'] ],
    }
}

# vim modeline - have 'set modeline' and 'syntax on' in your ~/.vimrc.
# vi:syntax=puppet:filetype=puppet:ts=4:et:
