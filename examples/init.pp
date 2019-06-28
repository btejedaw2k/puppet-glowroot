# test glowroot installation
class { 'glowroot' :
  version        => '0.13.4-dist',
  package_name   => 'glowroot',
  package_source => 'http://172.16.7.120/packages',
  config_path    => '/opt/glassfish-4.1.2',
  glowroot_agent => true,
}