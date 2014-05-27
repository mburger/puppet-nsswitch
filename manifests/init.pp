# = Class: nsswitch
#
# This is the main nsswitch class
#
#
# == Parameters
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, nsswitch class will automatically "include $my_class"
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, nsswitch main config file will have the param: source => $source
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, nsswitch main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#
# [*absent*]
#   Set to 'true' to remove all the resources installed by the module
#   Default: false
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet. Default: false
#
# [*noops*]
#   Set noop metaparameter to true for all the resources managed by the module.
#   Basically you can run a dryrun for this specific module if you set
#   this to true. Default: undef
#
class nsswitch (
  $my_class            = '',
  $source              = '',
  $template            = '',
  $options             = '',
  $absent              = false,
  $audit_only          = false,
  $noops               = undef
  ) inherits nsswitch::params {

  #################################################
  ### Definition of modules' internal variables ###
  #################################################

  # Variables defined in nsswitch::params
  $config_file=$nsswitch::params::config_file
  $config_file_mode=$nsswitch::params::config_file_mode
  $config_file_owner=$nsswitch::params::config_file_owner
  $config_file_group=$nsswitch::params::config_file_group

  $manage_file = $nsswitch::absent ? {
    true    => 'absent',
    default => 'present',
  }

  $manage_audit = $nsswitch::audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $nsswitch::audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $nsswitch::source ? {
    ''        => undef,
    default   => $nsswitch::source,
  }

  $manage_file_content = $nsswitch::template ? {
    ''        => undef,
    default   => template($nsswitch::template),
  }


  #######################################
  ### Resourced managed by the module ###
  #######################################

  # Configuration File
  file { 'nsswitch.conf':
    ensure  => $nsswitch::manage_file,
    path    => $nsswitch::config_file,
    mode    => $nsswitch::config_file_mode,
    owner   => $nsswitch::config_file_owner,
    group   => $nsswitch::config_file_group,
    source  => $nsswitch::manage_file_source,
    content => $nsswitch::manage_file_content,
    replace => $nsswitch::manage_file_replace,
    audit   => $nsswitch::manage_audit,
    noop    => $nsswitch::noops,
  }


  #######################################
  ### Optionally include custom class ###
  #######################################
  if $nsswitch::my_class {
    include $nsswitch::my_class
  }

}
