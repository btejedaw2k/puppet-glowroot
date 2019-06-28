# test glowroot installation
class { 'glowroot' :
  version               => '0.13.4-dist',
  package_name          => 'glowroot',
  package_source        => 'http://127.0.0.1/packages',
  config_path           => '/opt/glassfish-4.1.2',
  glowroot_agent        => true,
  application_name      => 'name of application of the server',
  location_name         => 'location of the server',
  glowroot_colector_url => 'url of the glowroot collector',
  glowroot_port_number  => 'port of glowroot collector',
}