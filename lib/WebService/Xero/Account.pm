package WebService::Xero::Account;

use Moose;
has 'ValidationErrors'      => (is => 'rw');
has 'Warnings'              => (is => 'rw');
has 'AccountID'             => (is => 'rw');
has 'Code'                  => (is => 'rw');
has 'Name'                  => (is => 'rw');
has 'Type'                  => (is => 'rw');
has 'BankAccountNumber'     => (is => 'rw');
has 'Status'                => (is => 'rw');
has 'Description'           => (is => 'rw');
has 'BankAccountType'       => (is => 'rw');
has 'CurrencyCode'          => (is => 'rw');
has 'TaxType'               => (is => 'rw');
has 'EnablePaymentsToAccount' => (is => 'rw');
has 'ShowInExpenseClaims'   => (is => 'rw');
has 'Class'                 => (is => 'rw');
has 'SystemAccount'         => (is => 'rw');
has 'ReportingCode'         => (is => 'rw');
has 'HasAttachments'        => (is => 'rw');
has 'HasAttachments'        => (is => 'rw');
has 'UpdatedDateUTC'        => (is => 'rw');

# For Canonical Specification see the XSDL
#    https://github.com/XeroAPI/XeroAPI-Schemas/blob/master/src/main/resources/XeroSchemas/v2.00/Account.xsd


sub TO_JSON  ## NB - this sub is required by JSON in parent Contact Class to use convert_blessed
{
    my ( $self ) = @_;
    return  {  'AccountID'         => $self->{AccountID},
               'Code'              => $self->{Code},  ## DEFAULT FAX  MOBILE DDI  ( maxLength 50 )
               'Name'              => $self->{Name}, ## maxlength 10
               'Type'              => $self->{Type}, ## maxlength 20
               'BankAccountNumber' => $self->{BankAccountNumber}
               # TODO: FINISH
            };
}
1;