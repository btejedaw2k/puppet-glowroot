# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include glowroot::install
class glowroot::install inherits glowroot {

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
}
