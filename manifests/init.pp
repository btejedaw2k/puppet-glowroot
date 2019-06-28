# @summary A short summary of the purpose of this class
# This class will install glowroot from a zip file and o thstalation
#
# A description of what this class does
#
# @example
#   include glowroot
class glowroot (
  Optional[Pattern[/^[.+_0-9:~-]+(\-\w+)?$/]] $version  = '0.13.4-dist',
  Enum['present','absent'] $package_ensure              = 'present',
  Enum['directory','absent'] $config_ensure             = 'directory',
  Enum['running','stopped'] $service_ensure             = 'running',
  String $package_type                                  = 'zip',
  String $operating_system                              = $::operatingsystem,
  String $operating_system_maj_release                  = $::operatingsystemmajrelease,
  Optional[String] $package_name                        = undef,
  Optional[String] $package_source                      = undef,
  Optional[String] $config_path                         = undef,
  Boolean $glowroot_master                              = false,
  Boolean $glowroot_agent                               = false,
  String $user_privilages                               = 'glassfish',
  String $group_privilages                              = 'glassfish',
  String $application_name                              = 'SandalsBeaches',
  String $location_name                                 = 'Toronto',
  String $glowroot_colector_url                         = 'http://torpglowrootap1.sandals.com',
  String $glowroot_port_number                          = '9090',
  ){
  # default variable
  $use_version = $version ? {
    undef   => '0.13.4-dist',
    default => $version,
  }
  $use_package_type = $package_type ? {
    undef   => 'zip',
    default => $package_type,
  }
  $use_package_name = $package_name ? {
    undef   => 'glowroot',
    default => $package_name,
  }
  $user_os_version = "${operating_system}/${operating_system_maj_release}"
  $use_package_source = $package_source ? {
    undef   => "http://172.16.7.120/packages/${user_os_version}/${use_package_name}-${use_version}.${use_package_type}",
    default => "${package_source}/${user_os_version}/${use_package_name}-${use_version}.${use_package_type}",
  }
  $use_default_path = $config_path ? {
    undef   => '/opt/glassfish-4.1.2',
    default => $config_path,
  }
  $use_config_path = "${use_default_path}/${use_package_name}"
  # module containment
  contain ::glowroot::install
}
