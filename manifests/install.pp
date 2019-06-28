# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include glowroot::install
class glowroot::install inherits glowroot {
  # Default variables for template
  $application  = $::glowroot::application_name
  $location          = $::glowroot::location_name
  $glowroot_colector = $::glowroot::glowroot_colector_url
  $glowroot_port     = $::glowroot::glowroot_port_number

  # archive module
  include ::archive

  # default file permissions
  File{
    owner                   => $::glowroot::user_privilages,
    group                   => $::glowroot::group_privilages,
    selinux_ignore_defaults => true,
  }
  # create config file
  file { $::glowroot::config_path :
    ensure => $::glowroot::config_ensure,
  }
  # uncompress the glowroot pacakge
  archive { $::glowroot::package_name :
    ensure       => $::glowroot::package_ensure,
    path         => "${::glowroot::config_path}/${::glowroot::package_name}-${::glowroot::version}.${glowroot::package_type}",
    source       => $::glowroot::use_package_source,
    extract      => true,
    extract_path => $::glowroot::config_path,
    cleanup      => true,
    user         => $::glowroot::user_privilages,
    group        => $::glowroot::group_privilages,
    require      => File[$::glowroot::config_path]
  }

  file { "${::glowroot::config_path}/${::glowroot::package_name}/glowroot.properties" :
    ensure  => 'file',
    content => template("${module_name}/agent_configuration.erb"),
    require => Archive[$::glowroot::package_name],
  }
}
