#!/usr/bin/perl

use strict;
use warnings;
use WebService::Xero::Contact;
use WebService::Xero::DateTime;
use JSON::PP;
use Data::Dumper;




my $c = WebService::Xero::Contact->new(

                            'IsSupplier' => JSON::PP::false,
                            'ContactStatus' => 'ACTIVE',
                            'BankAccountDetails' => '',
                            'EmailAddress' => '',
                            'UpdatedDateUTC' => '/Date(1487614324277+0000)/',
                            'HasAttachments' => JSON::PP::false,
                            'Addresses' => [
                                             {
                                               'Country' => '',
                                               'Region' => '',
                                               'PostalCode' => '',
                                               'City' => '',
                                               'AddressType' => 'STREET'
                                             },
                                             {
                                               'Region' => '',
                                               'Country' => '',
                                               'PostalCode' => '',
                                               'AddressType' => 'POBOX',
                                               'City' => ''
                                             }
                                           ],
                            'ContactPersons' => [],
                            'IsCustomer' => JSON::PP::false,
                            'Name' => 'Jane Scott',
                            'HasValidationErrors' => JSON::PP::false,
                            'ContactGroups' => [],
                            'Phones' => [
                                          {
                                            'PhoneNumber' => '',
                                            'PhoneType' => 'DDI',
                                            'PhoneCountryCode' => '',
                                            'PhoneAreaCode' => ''
                                          },
                                          {
                                            'PhoneNumber' => '',
                                            'PhoneAreaCode' => '',
                                            'PhoneCountryCode' => '',
                                            'PhoneType' => 'DEFAULT'
                                          },
                                          {
                                            'PhoneNumber' => '',
                                            'PhoneType' => 'FAX',
                                            'PhoneCountryCode' => '',
                                            'PhoneAreaCode' => ''
                                          },
                                          {
                                            'PhoneCountryCode' => '',
                                            'PhoneAreaCode' => '',
                                            'PhoneType' => 'MOBILE',
                                            'PhoneNumber' => ''
                                          }
                                        ],
                            'ContactID' => '1b4c189f-2c88-4eb1-b052-004b9704d757'
                          
);

print $c->as_text( "\n", 1 );
# print "\n-- When Updated = " . $c->{UpdatedDateUTC}->as_text();

#my $p = WebService::Xero::DateTime->new( $c->{UpdatedDateUTC} );
#print Dumper $c->{UpdatedDateUTC} ;
#exit;
