# Puppet module: nsswitch

This is a Puppet module for nsswitch.

Based on a template defined in http://github.com/Example42-templates/

Released under the terms of Apache 2 License.


## USAGE - Basic management

* Install nsswitch with default settings

        class { 'nsswitch': }

* Install a specific version of nsswitch package

        class { 'nsswitch':
          version => '1.0.1',
        }

* Disable nsswitch service.

        class { 'nsswitch':
          disable => true
        }

* Remove nsswitch package

        class { 'nsswitch':
          absent => true
        }

* Enable auditing without without making changes on existing nsswitch configuration *files*

        class { 'nsswitch':
          audit_only => true
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'nsswitch':
          noops => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { 'nsswitch':
          source => [ "puppet:///modules/example42/nsswitch/nsswitch.conf-${hostname}" , "puppet:///modules/example42/nsswitch/nsswitch.conf" ], 
        }


* Use custom source directory for the whole configuration dir

        class { 'nsswitch':
          source_dir       => 'puppet:///modules/example42/nsswitch/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file. Note that template and source arguments are alternative. 

        class { 'nsswitch':
          template => 'example42/nsswitch/nsswitch.conf.erb',
        }

* Automatically include a custom subclass

        class { 'nsswitch':
          my_class => 'example42::my_nsswitch',
        }

## TESTING
[![Build Status](https://travis-ci.org/example42/puppet-nsswitch.png?branch=master)](https://travis-ci.org/example42/puppet-nsswitch)

