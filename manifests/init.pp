# @summary A short summary of the purpose of this class
# This class will install glowroot from a zip file and o thstalation
#
# A description of what this class does
#
# @example
#   include glowroot
class glowroot (
  Optional[Pattern[/^[.+_0-9:~-]+(\-\w+)?$/]] $version,
  Enum['present','absent'] $package_ensure,
  Enum['directory','absent'] $config_ensure,
  Enum['running','stopped'] $service_ensure,
  String $package_type,
  Optional[String] $package_name,
  Optional[String] $package_source,
  Optional[String] $config_path,
  Boolean $glowroot_master,
  Boolean $glowroot_agent,
  String $user_privilages,
  String $group_privilages,
  String $application_name,
  String $location_name,
  String $glowroot_colector_url,
  String $glowroot_port_number,
  ){
  $os_version = "${::operatingsystem}/${::operatingsystemmajrelease}"
  $use_package_source ="${package_source}/${os_version}/${package_name}-${version}.${package_type}"
  $use_config_path = "${config_path}/${package_name}"
  # module containment
  contain ::glowroot::install
}
