package WebService::Xero::Phone;

use Moose;
has 'PhoneNumber'      => (is => 'rw');
has 'PhoneType'      => (is => 'rw');
has 'PhoneAreaCode'  => (is => 'rw');
has 'PhoneCountryCode' => (is => 'rw');



sub TO_JSON  ## NB - this sub is required by JSON in parent Contact Class to use convert_blessed
{
    my ( $self ) = @_;
    return  {  'PhoneNumber'   => $self->{PhoneNumber},
               'PhoneType'     => $self->{PhoneType},
               'PhoneAreaCode'     => $self->{PhoneAreaCode},
               'PhoneCountryCode'     => $self->{PhoneCountryCode}
            };
}
1;