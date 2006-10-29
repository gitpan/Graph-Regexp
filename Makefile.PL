# We need at least Perl 5.8.1 for proper Unicode support
require 5.8.1;
use strict;

# Load the Module::Install bundled in ./inc/
use inc::Module::Install;

# The name of your distribution
name		'Graph-Regexp';

# Get most of the details from the primary module
all_from	'lib/Graph/Regexp.pm';

requires	'Scalar::Util'		=> 1.13,
		'Graph::Easy'		=> 0.49;

build_requires  'Test::More'		=> 0.42,
		'Test::Differences'	=> 0.47;

license		'gpl';			# v2.0 only

author		'Tels <nospam-abuse@bloodgate.com>';

# Do not index these
no_index	directory	=>	'examples';

# Auto-install all dependencies from CPAN
auto_install;

# Generate the Makefile
WriteAll;