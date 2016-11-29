package WebService::Xero::Organisation;

use 5.006;
use strict;
use warnings;

use Data::Dumper;
=head1 NAME

WebService::Xero::Organisation - contains information about a Xero organisation

=head1 VERSION

Version 0.10

=cut

our $VERSION = '0.10';

our @PARAMS = qw/Name LegalName Version OrganisationType BaseCurrency CountryCode RegistrationNumber TaxNumber FinancialYearEndDay FinancialYearEndMonth LineOfBusiness /;



=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use  WebService::Xero::Organisation;

    my $foo =  WebService::Xero::Organisation->new();
    ...

=head1 TODO

consider inclusion of Locale modules - Locale::Currency and Locale::Country

=head1 METHODS

=head2 new()

=cut

sub new 
{
  my ( $class, %params ) = @_;

    my $self = bless 
    {
      APIKey       => $params{APIKey} || undef,
      Name         => $params{Name} || '',
      LegalName    => $params{LegalName}    || "",
      debug => $params{debug}

    }, $class;
    foreach my $key (@PARAMS) { $self->{$key} = $params{$key} || '' }

    return $self; #->_validate_agent(); ## derived classes will validate this

}


=head2 new_from_api_data()

  creates a new instance from the data provided by querying the API organisation end point 
  ( typically handled by WebService::Xero::Agent->api_account_organisation() which calls this method )

=cut 

sub new_from_api_data
{
  my ( $self, $data ) = @_;
  return $self->new(  %{$data->{Organisations}[0]} ) if ( ref($data->{Organisations}) eq 'ARRAY' and scalar(@{$data->{Organisations}})==1 );  
  return $self->new( debug=> $data );  

}

=head2 as_text()

=cut


sub as_text 
{
    my ( $self ) = @_;

    return join("\n", map { "$_ : $self->{$_}" } @PARAMS);





}

=head1 AUTHOR

Peter Scott, C<< <peter at computerpros.com.au> >>


=head1 REFERENCE


=head1 BUGS

Please report any bugs or feature requests to C<bug-ccp-xero at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=CCP-Xero>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


APIKey  
Name        Display name of organisation shown in Xero
LegalName   Organisation name shown on Reports
PaysTax     Boolean to describe if organisation is registered with a local tax authority i.e. true, false
Version     See Version Types
OrganisationType    Organisation Type
BaseCurrency    Default currency for organisation. See ISO 4217 Currency Codes
CountryCode Country code for organisation. See ISO 3166-2 Country Codes
  IsDemoCompany   Boolean to describe if organisation is a demo company.
  OrganisationStatus  Will be set to ACTIVE if you can connect to organisation via the Xero API
RegistrationNumber  Shows for New Zealand, Australian and UK organisations
TaxNumber   Shown if set. Displays in the Xero UI as Tax File Number (AU), GST Number (NZ), VAT Number (UK) and Tax ID Number (US & Global).
FinancialYearEndDay Calendar day e.g. 0-31
FinancialYearEndMonth   Calendar Month e.g. 1-12
SalesTaxBasis   The accounting basis used for tax returns. See Sales Tax Basis
SalesTaxPeriod  The frequency with which tax returns are processed. See Sales Tax Period
DefaultSalesTax The default for LineAmountTypes on sales transactions
DefaultPurchasesTax The default for LineAmountTypes on purchase transactions
PeriodLockDate  Shown if set. See lock dates
EndOfYearLockDate   Shown if set. See lock dates
CreatedDateUTC  Timestamp when the organisation was created in Xero
OrganisationEntityType  Timezone specifications
ShortCode   A unique identifier for the organisation. Potential uses.
LineOfBusiness  Description of business type as defined in Organisation settings
Addresses   Address details for organisation – see Addresses
Phones  Phones details for organisation – see Phones
ExternalLinks   Organisation profile links for popular services such as Facebook, Twitter, GooglePlus and LinkedIn. You can also add link to your website here. Shown if Organisation settings is updated in Xero. See ExternalLinks below
PaymentTerms    Default payment terms for the organisation if set – See Payment Terms below




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WebService::Xero::Organisation


You can also look for information at:

=over 4

=item * Xero Developer API Docs

L<https://developer.xero.com/documentation/api/organisation/>


=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2016 Peter Scott.

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
