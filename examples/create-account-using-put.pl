#!/usr/bin/perl

use strict;
use warnings;

use Config::Tiny;
use WebService::Xero::Agent::PrivateApplication;
use Crypt::OpenSSL::RSA;
use Data::Dumper;
use File::Slurp; ## readfile
use DateTime;
use Time::Local;
use feature 'say';
use JSON::XS;

=pod

create-account-using-put.pl



=cut


die('Configuration is assumed to be defined in the ./t/config/test_config.ini file - copy the template file in the same directory and modify with references to your Private Application API keys and secret') unless -e '../t/config/test_config.ini';
my $config =  Config::Tiny->read( '../t/config/test_config.ini') || die('failed to load config');
my $pk_text = read_file( $config->{PRIVATE_APPLICATION}{KEYFILE} );
my $pko = Crypt::OpenSSL::RSA->new_private_key( $pk_text ); # 'Generate RSA Object from private key file'

my $xero = WebService::Xero::Agent::PrivateApplication->new( 
                                                          NAME            => $config->{PRIVATE_APPLICATION}{NAME},
                                                          CONSUMER_KEY    => $config->{PRIVATE_APPLICATION}{CONSUMER_KEY}, 
                                                          CONSUMER_SECRET => $config->{PRIVATE_APPLICATION}{CONSUMER_SECRET}, 
                                                         # KEYFILE         => $config->{PRIVATE_APPLICATION}{KEYFILE},
                                                          PRIVATE_KEY     => $pk_text,
                                                          );


my $account_def_xml = new_account_xml();
 
 my $response = $xero->do_xero_api_call( 'https://api.xero.com/api.xro/2.0/Accounts' , 'PUT', $account_def_xml ) || die( 'Request failed: ' . $xero->{_status} );
 
 print Dumper $response;

sub new_account_xml
{
  return q{<Account>
  <Code>205</Code>
  <Name>TEST SALES 2</Name>
  <Type>SALES</Type>
  <TaxType>OUTPUT</TaxType>
</Account>};

} 

