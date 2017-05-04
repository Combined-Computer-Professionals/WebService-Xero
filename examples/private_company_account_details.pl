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
my $DEBUG = 1; ## if set display debug info

=pod

=head1 private_company_account_details.pl

=head2 CONFIGURATION

private application credentials are assumed to have been specified in the 

=head2 USAGE

Ensure that configuration is set in ./t/config/test_config.ini

./private_company_account_details.pl

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
## AND THEN ACCESS THE XERO API POINTS

my $contact_response = $xero->do_xero_api_call( 'https://api.xero.com/api.xro/2.0/Contacts' ) || die( 'TODO: add a reference to error condition' );

print qq{
    RESPONSE: 
          $contact_response->{'DateTimeUTC'}
          $contact_response->{'Id'}
          $contact_response->{'Status'}
          $contact_response->{'ProviderName'}
          $contact_response->{'Contacts'}

} if $DEBUG;

#my $utc_str = 0;
#if ( $contact_response->{'DateTimeUTC'} =~ /Date\((\d+)\)/smg )
#{
#    $utc_str = $1;
#}
#print "utc as string = $utc_str\n";
#my $utc = DateTime->from_epoch( epoch => $utc_str/1000 ); ## Xero JSON responses are in milliseconds so divide by 1000 for seconds
#say $utc;

my $xero_dt = WebService::Xero::DateTime->new( $contact_response->{'DateTimeUTC'} );
say $xero_dt->as_datetime();

=pod 

foreach my $contact ( @$contact_struct )
{
  print Dumper $contact;
            'ProviderName' => 'ShotgunDriver Subscription Manager',
          'DateTimeUTC' => '/Date(1493793657307)/',
          'Id' => 'e0d6de15-d2ae-4fd1-935e-16b85c9c6b2c',
          'Status' => 'OK'
}
=cut
print Dumper $contact_response; ## should contain an array of hashes containing contact data.



package WebService::Xero::DateTime;
sub new 
{
    my ( $class, $xero_date_string ) = @_;
    my $self = {
      _utc => 0,
    };
    if ( $xero_date_string =~ /Date\((\d+)[^\d]/smg )
    {
        $utc_str = $1;
        $self->{_utc} = DateTime->from_epoch( epoch => $utc_str/1000 ) || die("critical failure creating date from $xero_date_string");

        return bless $self, $class;
    }
    return undef; ## default if conditions aren't right
    
}

sub as_datetime
{
    my ( $self ) = @_;
    return $self->{_utc};

}
