# test glowroot installation
class { 'glowroot' :
  version               => '0.13.4-dist',
  package_name          => 'glowroot',
  package_source        => 'http://127.0.0.1/packages',
  config_path           => '/tmp/glowroot',
  glowroot_agent        => true,
  application_name      => 'glowroot',
  location_name         => 'Himalaya',
  glowroot_colector_url => 'http://www.glowroot.com',
  glowroot_port_number  => '80',
}