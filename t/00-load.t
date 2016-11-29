#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 4;

BEGIN {
    use_ok( 'WebService::Xero' ) || print "Bail out!\n";
    use_ok( 'WebService::Xero::Agent' ) || print "Bail out!\n";
    use_ok( 'WebService::Xero::Agent::PublicApplication' )  || print "Bail out!\n";
    use_ok( 'WebService::Xero::Agent::PrivateApplication' ) || print "Bail out!\n";
    #use_ok( 'WebService::Xero::Agent::PartnerApplication' ) || print "Bail out!\n";
}

diag( "Testing WebService::Xero $WebService::Xero::VERSION, Perl $], $^X" );
