# Add Nginx stable repository
exec { 'add-nginx-stable-repo':
  command => 'add-apt-repository ppa:nginx/stable',
  path    => '/usr/bin:/usr/sbin:/bin',
}

# Update package list
exec { 'update-packages':
  command => 'apt-get update',
  path    => '/usr/bin:/usr/sbin:/bin',
}

# Install Nginx
package { 'nginx':
  ensure => present,
}

# Allow HTTP traffic
exec { 'allow-http':
  command => "ufw allow 'Nginx HTTP'",
  path    => '/usr/bin:/usr/sbin:/bin',
}

# Change permissions of /var/www folder
exec { 'chmod-www-folder':
  command => 'chmod -R 755 /var/www',
  path    => '/usr/bin:/usr/sbin:/bin',
}

# Create index.html file
file { '/var/www/html/index.html':
  content => "Hello World!\n",
}

# Create 404.html file
file { '/var/www/html/404.html':
  content => "Ceci n'est pas une page\n",
}

# Configure Nginx default site
file { '/etc/nginx/sites-enabled/default':
  ensure  => file,
  content =>
"server {
        listen 80 default_server;
        listen [::]:80 default_server;
        root /var/www/html;
        index index.html index.htm index.nginx-debian.html;
        server_name _;
        location / {
                try_files \$uri \$uri/ =404;
        }
        error_page 404 /404.html;
        location /404.html {
            internal;
        }
        if (\$request_filename ~ redirect_me){
            rewrite ^ https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;
        }
}
",
}

# Restart Nginx service
exec { 'restart-nginx':
  command => 'service nginx restart',
  path    => '/usr/bin:/usr/sbin:/bin',
}

# Ensure Nginx service is running
service { 'nginx':
  ensure => running,
}
