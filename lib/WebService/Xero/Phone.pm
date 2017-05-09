package WebService::Xero::Phone;

use Moose;
has 'PhoneNumber'      => (is => 'rw');
has 'PhoneType'        => (is => 'rw');
has 'PhoneAreaCode'    => (is => 'rw');
has 'PhoneCountryCode' => (is => 'rw');

# For Canonical Specification see the XSDL
#    https://github.com/XeroAPI/XeroAPI-Schemas/blob/master/src/main/resources/XeroSchemas/v2.00/Phone.xsd


sub TO_JSON  ## NB - this sub is required by JSON in parent Contact Class to use convert_blessed
{
    my ( $self ) = @_;
    return  {  'PhoneNumber'   => $self->{PhoneNumber},
               'PhoneType'     => $self->{PhoneType},  ## DEFAULT FAX  MOBILE DDI  ( maxLength 50 )
               'PhoneAreaCode'     => $self->{PhoneAreaCode}, ## maxlength 10
               'PhoneCountryCode'     => $self->{PhoneCountryCode}, ## maxlength 20
               'ValidationErrors' => $self->{ValidationErrors}
               # 'Warnings'
            };
}
1;