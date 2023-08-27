# make changes to configuration file
include stdlib

file_line { 'Turn off password authentication':
  ensure  => present,
  path    => '/etc/ssh/ssh_config',
  line    => '    PasswordAuthentication no',
  replace => true,
}

file_line { 'Set identity file':
  ensure  => present,
  path    => '/etc/ssh/ssh_config',
  line    => '     IdentityFile ~/.ssh/school',
  replace => true,
}
