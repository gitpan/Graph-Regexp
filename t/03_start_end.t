#!/usr/bin/perl -w

# test BOL,EOL, EOS etc as in /^foo$/ /\Afoo\Z/ etc.

use Test::More;
use strict;

BEGIN
   {
   plan tests => 28;
   chdir 't' if -d 't';
   use lib '../lib';
   use_ok ("Graph::Regexp") or die($@);
   };

#############################################################################
# inputs:

my $bol = <<BOL
   1: BOL(2)
   2: EXACT <foo>(4)
   4: END(0)
BOL
;

my $eol = <<EOL
   1: EXACT <foo>(3)
   3: EOL(4)
   4: END(0)
EOL
;

my $bol_and_eol = <<BOL_EOL
   1: BOL(2)
   2: EXACT <foo>(4)
   4: EOL(5)
   5: END(0)
BOL_EOL
;

my $eos = <<EOS
   1: EXACT <foo>(3)
   3: EOS(4)
   4: END(0)
EOS
;

my $sbol_and_seol = <<SBOL_SEOL
   1: SBOL(2)
   2: EXACT <foo>(4)
   4: SEOL(5)
   5: END(0)
SBOL_SEOL
;

#############################################################################
#############################################################################
# tests:

_check_graph($bol, 5,5, 1,'BOL (^)' );
_check_graph($eol, 5,5, 3,'EOL ($)' );
_check_graph($eos, 5,5, 3,'EOS (\\z)' );
_check_graph($bol_and_eol, 6,7, 1,'BOL (^)', 4, 'EOL ($)' );
_check_graph($sbol_and_seol, 6,7, 1,'SBOL (\\A)', 4, 'SEOL (\\Z)' );

#############################################################################

sub _check_graph
  {
  my ($input, $n, $e, @checks) = @_;

  my $graph = Graph::Regexp->graph( \$input );

  $n ||= 5; $e ||= 5;

  is (ref($graph), 'Graph::Easy');

  is ($graph->error(), '', 'no error');

  is (scalar $graph->nodes(), $n, "$n nodes");
  is (scalar $graph->edges(), $e, "$e edges");

  while (@checks)
    {
    my $nr = shift @checks;
    my $label = shift @checks;
    is ($graph->node($nr)->label(), $label, "$label included");
    }
  }
