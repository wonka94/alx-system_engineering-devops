# Update package lists
exec { 'update':
  command => 'apt-get update',
  path    => ['/usr/bin', '/usr/sbin'],
}

# Install Nginx
package { 'nginx':
  ensure  => installed,
  require => Exec['update'],
}

# Add custom header
file_line { 'add_header':
  path   => '/etc/nginx/nginx.conf',
  line   => "add_header X-Served-By \"${hostname}\";",
  match  => '^http {',
  after  => '^http {',
  require => Package['nginx'],
}

# Restart Nginx
exec { 'restart_nginx':
  command     => 'service nginx restart',
  path        => ['/usr/bin', '/usr/sbin'],
  refreshonly => true,
  subscribe   => File_line['add_header'],
}
