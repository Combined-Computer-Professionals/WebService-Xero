package WebService::Xero::Contact;

use 5.006;
use strict;
use warnings;
use Carp;

use Data::Dumper;
use WebService::Xero::DateTime;

=head1 NAME

WebService::Xero::Contact - encapsulates a Xero API Contact record

=head1 VERSION

Version 0.12

=cut

our $VERSION = '0.12';

our @PARAMS = qw/ContactID ContactStatus Name FirstName LastName EmailAddress BankAccountDetails UpdatedDateUTC IsCustomer IsSupplier HasAttachments HasValidationErrors
                 Addresses Phones ContactGroups ContactPersons
                /;



=head1 SYNOPSIS


Object to describe an Contact record as specified by Xero API and the associated DTD at 
L<https://github.com/XeroAPI/XeroAPI-Schemas/blob/master/src/main/resources/XeroSchemas/v2.00/Contact.xsd>.

Mostly a wrapper for Xero Contact data structure.




Example.

    use  WebService::Xero::Contact;

    my $agent            = WebService::Xero::Agent::PrivateApplication->new( ... etc 
    my $contact_response = $xero->do_xero_api_call( 'https://api.xero.com/api.xro/2.0/Contacts' ) || die( 'TODO: add a reference to error condition' );

    my $contact =  WebService::Xero::Contact->new( $contact_response );
    print $contact->as_text();

=head2 NOTES

    You can upload up to 10 attachments(each up to 3mb in size) per contact, once the contact has been created in Xero.

=head1 METHODS

=head2 new()

=cut

sub new 
{
  my ( $class, %params ) = @_;

    my $self = bless 
    {
      debug => $params{debug},
      API_URL => 'https://api.xero.com/api.xro/2.0/Contacts',

    }, $class;
    foreach my $key (@PARAMS) { $self->{$key} = defined $params{$key} ? $params{$key} : '';  }

    ## ContactStatus: [ ACTIVE || ARCHIVED ]

    return $self; #->_validate_agent(); ## derived classes will validate this

}


=head2 new_from_api_data()

  creates a new instance from the data provided by querying the API organisation end point 
  ( typically handled by WebService::Xero::Agent->do_xero_api_call() )

  Example Contact Queries using Xero Agent that return Data consumable by this method:
    https://api.xero.com/api.xro/2.0/Contacts

  Returns undef, a single object instance or an array of object instances depending on the data input provided.


=cut 

sub new_from_api_data
{
  my ( $self, $data ) = @_;
  return WebService::Xero::Contact->new(  %{$data->{Contacts}[0]} ) if ( ref($data->{Contacts}) eq 'ARRAY' and scalar(@{$data->{Contacts}})==1 );  
  return WebService::Xero::Contact->new( debug=> $data );  

}

=head2 as_text()

  mostly for debugging.

=cut


sub as_text 
{
    my ( $self ) = @_;

    return join("\n", map { "$_ : $self->{$_}" } @PARAMS);
}


=head2 as_json()

  mostly for debugging.

=cut
sub as_json
{
  my ( $self ) = @_; 
  return undef; ## TODO:
}

=head1 AUTHOR

Peter Scott, C<< <peter at computerpros.com.au> >>


=head1 REFERENCE


=head1 BUGS

Please report any bugs or feature requests to C<bug-webservice-xero at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WebService-Xero>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 TODO


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WebService::Xero::Contact


You can also look for information at:

=over 4

=item * Xero Developer API Docs

L<https://developer.xero.com/documentation/api/contacts/>


=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2016-2017 Peter Scott.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of WebService::Xero
