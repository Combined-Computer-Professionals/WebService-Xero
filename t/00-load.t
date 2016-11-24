#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 4;

BEGIN {
    use_ok( 'CCP::Xero' ) || print "Bail out!\n";
    use_ok( 'CCP::Xero::Agent' ) || print "Bail out!\n";
    use_ok( 'CCP::Xero::Agent::PublicApplication' )  || print "Bail out!\n";
    use_ok( 'CCP::Xero::Agent::PrivateApplication' ) || print "Bail out!\n";
    #use_ok( 'CCP::Xero::Agent::PartnerApplication' ) || print "Bail out!\n";
}

diag( "Testing CCP::Xero $CCP::Xero::VERSION, Perl $], $^X" );
