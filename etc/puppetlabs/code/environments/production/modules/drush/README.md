puppet-drush
===============

[![Build
Status](https://secure.travis-ci.org/previousnext/puppet-drush.png)](http://travis-ci.org/previousnext/puppet-drush)

This module installs [Drush](http://www.drush.org//), a command line shell and
Unix scripting interface for Drupal.

Installation
------------

Using the Puppet Module Tool, install the
[`previousnext/drush`](http://forge.puppetlabs.com/previousnext/drush) module by
running the following command:

    puppet module install previousnext/drush

Otherwise, clone this repository and make sure to install the proper
dependencies ([`puppet-composer`](https://github.com/willdurand/puppet-composer)):

    git clone git://github.com/previousnext/puppet-drush.git modules/drush

**Important:** the right `puppet-composer` module is
[willdurand/puppet-composer](https://github.com/willdurand/puppet-composer).
Do **not** use any other `puppet-composer` module.

Usage
-----

Include the `drush::drush` class:

    include drush::drush

You can specify the version you want to install:

    drush::drush { 'drush8':
      version => '8',
    }

You can specify the link name you want to get, and the target directory (aka
where to install Drush):

    drush::drush { 'drush':
      link_name => '/usr/local/bin/drush',
      target_dir   => '/usr/local'
    }

You can specify a particular `user` that will be the owner of the Drush
directory:

    drush::drush { 'drush7':
      user => 'foo',
    }

It is possible to install multiple versions side by side, but remember to pass
a custom link name for each if you do:

    drush::drush { 'drush8':
      version      => '8',
      link_name => '/usr/local/bin/drush8',
    }

    drush::drush { 'drush7':
      link_name => '/usr/local/bin/drush7',
    }

Or you can use hiera to specify drush resources:

    ---
    classes:
      - drush

    drush:
      drush62
        version:   '6.2'
        link_name: '/usr/local/bin/drush-legacy'
      drush67
        version:   '6.7'
      drush7
        version:   '7'
        link_name: '/usr/local/bin/drush7'
      drush8
        version:   '8'
        link_name: '/usr/local/bin/drush8'

Running the tests
-----------------

Install the dependencies using [Bundler](http://gembundler.com):

    BUNDLE_GEMFILE=.gemfile bundle install

Run the following command:

    BUNDLE_GEMFILE=.gemfile bundle exec rake validate lint spec SPEC_OPTS='--format documentation'

License
-------

puppet-drush is released under the  License. See the bundled LICENSE file
for details.


Acknowledgement
---------------

puppet-drush is based on [puppet-composer](https://github.com/willdurand/puppet-composer) by William Durand.
