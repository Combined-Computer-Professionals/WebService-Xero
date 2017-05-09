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
use WebService::Xero::DateTime;
use WebService::Xero::Contact;
use feature 'say';
use JSON::XS;
my $DEBUG = 1; ## if set display debug info


=pod

=head1 private_contact_details.pl

=head2 SYNOPSIS

 walks through a couple of approaches to retrieving Contact records

=head2 CONFIGURATION

 private application credentials are assumed to have been specified in the t/config/test_config.ini file

=head2 USAGE

 Ensure that configuration is set in ./t/config/test_config.ini
 Uncomment lines as appropriate or modify (1==1) <-> (1==2) to enable or disable blocks of code
 ./private_company_account_details.pl

=cut



## Start by creating a PrivateApplication Agent to access Xero API

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

##### APPROACH 1 - Construct the API call URLS manually and handle the response

if ( 1==1 ) ## show usage by performing direct API call and then converting the result into contact object(s)
{
  ## uncomment one of these to either query for a single or all Contacts using the agent do_xero_api_call method.
  my $contact_response = $xero->do_xero_api_call( 'https://api.xero.com/api.xro/2.0/Contacts' ) || die( 'TODO: add a reference to error condition' );
  ##my $contact_response = $xero->do_xero_api_call( 'https://api.xero.com/api.xro/2.0/Contacts/1b4c189f-2c88-4eb1-b052-004b9704d757' ) || die( 'TODO: add a reference to error condition' );
  print qq{
      XERO RESPONSE: 
            $contact_response->{'DateTimeUTC'}
            $contact_response->{'Id'}
            $contact_response->{'Status'}
            $contact_response->{'ProviderName'}          
  } if $DEBUG;
  #print Dumper $contact_response->{'Contacts'} if $DEBUG;

  
  ## NB the response MAY not include all records .. Xero suggests you paginate reqeusts into 100 record blocks to ensure all records - this is handled by the Class using Contacts get_all_using_agent method ( Approach 2 below )
  ## $contact_response->{'Contacts'} contains JSON data describing the contacts but to use we need to handle the Xero Date formatting, booleans etc
  if ( $contact_response->{'Contacts'} > 0 ) 
  {
    print "Response returned " . scalar(@{$contact_response->{'Contacts'}} ) . " records\n";
    # print contacts_list_as_json( WebService::Xero::Contact->new_array_from_api_data( $contact_response) ); ## convert the response into a list of WebService::Xero:Contact instances and print as JSON
  } else {
    print "Xero did not return any Contacts\n";
  }

}


###### APPROACH 2 - Recommended for retrieving all contact records

if ( 1==2 ) ## 
{
  my $contact_list = WebService::Xero::Contact->get_all_using_agent( agent=> $xero ); 
  foreach my $contact ( @$contact_list )
  {
    # print $contact->as_json(); ## can use method to dump a single record as JSON
    print "$contact->{Name} $contact->{FirstName} $contact->{LastName} $contact->{EmailAddress}\n";
  }
  ## print contacts_list_as_json( $contact_list ); 
  exit;

}




sub contacts_list_as_json
{
  my ( $contact_list ) = @_;
  ## CURRENTLY TO DUMP LIST AS JSON NEED TO DO A LITTLE DANCE
  ##  thinking about creating a container class to wrap this and an iterator ..
  my $json = new JSON::XS;
  $json = $json->convert_blessed ([1]);
  return  $json->encode( $contact_list ) ; #();
  #print to_json(@$contact_list );
}


exit;

=pod 

=head2 NOTES

## The Datestring returned by Xero needs to be converted to a DateTime to simplify manipulation (done in DateTime.pm )

my $utc_str = 0;
if ( $contact_response->{'DateTimeUTC'} =~ /Date\((\d+)\)/smg )
{
    $utc_str = $1;
}
print "utc as string = $utc_str\n";
my $utc = DateTime->from_epoch( epoch => $utc_str/1000 ); ## Xero JSON responses are in milliseconds so divide by 1000 for seconds
say $utc;

my $xero_dt = WebService::Xero::DateTime->new( $contact_response->{'DateTimeUTC'} );
say $xero_dt->as_datetime();

Returning an arrayref of objects like this is pretty ugly .. thinking about approaches to abstracting a container class that generalises well.

TODO: explore the use of filters in constructing the API query string. 


=cut



