#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 11;
use Test::Deep;

use_ok( 'Medical::OPCS4' );

my $O = Medical::OPCS4->new();

$O->parse('./t/testdata.txt');

my $Term = $O->get_term('O16');

is( $Term->term, 'O16' );
is( $Term->description, 'Body region' );

is( $O->get_term('Moo'), undef );

my $ra_all_terms = $O->get_all_terms();

is( scalar(@$ra_all_terms), 6, 'get_all_terms()' );

my $rh_all_terms = $O->get_all_terms_hashref();

is ( scalar( keys %$rh_all_terms), '6', 'get_all_terms_hashref()' );

my $Parent = $O->get_parent_term( $Term );

is( $Parent->term, 'root' );
is( $Parent->description, 'This is the root node.');

$Parent = $O->get_parent_term( 'O16.1' );

is( $Parent->term, 'O16' );
is( $Parent->description, 'Body region');

my $ra_ch = $O->get_child_terms( 'O16' );

is( scalar(@$ra_ch), 4, 'get_child_terms' );
