# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include glowroot::install
class glowroot::install inherits glowroot {
  # Default variables
  $package_source    = $::glowroot::use_package_source
  $package_name      = $::glowroot::use_package_name
  $package_type      = $::glowroot::use_package_type
  $package_version   = $::glowroot::use_version
  $default_path      = $::glowroot::use_default_path
  $application       = $::glowroot::application_name
  $location          = $::glowroot::location_name
  $glowroot_colector = $::glowroot::glowroot_colector_url
  $glowroot_port     = $::glowroot::glowroot_port_number

  # archive module
  include ::archive
  # create config file
  file { $default_path :
    ensure                  => $::glowroot::config_ensure,
    owner                   => $::glowroot::user_privilages,
    group                   => $::glowroot::group_privilages,
    selinux_ignore_defaults => true,
  }
  # uncompress the glowroot pacakge
  archive { $package_name :
    ensure       => $::glowroot::package_ensure,
    path         => "${default_path}/${package_name}-${package_version}.${package_type}",
    source       => $package_source,
    extract      => true,
    extract_path => $default_path,
    cleanup      => true,
    user         => $::glowroot::user_privilages,
    group        => $::glowroot::group_privilages,
    require      => File[$default_path]
  }

  file { "${default_path}/${package_name}/glowroot.properties" :
    ensure  => 'file',
    owner   => $::glowroot::user_privilages,
    group   => $::glowroot::group_privilages,
    content => template("${module_name}/agent_configuration.erb"),
    require => Archive[$package_name],
  }
}
