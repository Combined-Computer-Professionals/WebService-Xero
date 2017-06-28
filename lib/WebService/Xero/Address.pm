package WebService::Xero::Address;

use Moose;
 
has 'AddressLine1'   => (is => 'rw');
has 'Country'        => (is => 'rw');
has 'City'           => (is => 'rw');
has 'AddressLine3'   => (is => 'rw');
has 'AttentionTo'    => (is => 'rw');
has 'AddressLine2'   => (is => 'rw');
has 'PostalCode'     => (is => 'rw');
has 'AddressType'    => (is => 'rw');
has 'AddressLine4'   => (is => 'rw');
has 'Region'         => (is => 'rw');

sub TO_JSON
{
    my ( $self ) = @_;
    return {
        AddressLine1 => $self->{AddressLine1},
        Country      => $self->{Country},
        City         => $self->{City},
        AddressLine3 => $self->{AddressLine3},
        AttentionTo  => $self->{AttentionTo},
        AddressLine2 => $self->{AddressLine2},
        PostalCode   => $self->{PostalCode},
        AddressType  => $self->{AddressType},  ## POBOX | STREET | DELIVERY
        AddressLine4 => $self->{AddressLine4},
        Region       => $self->{Region},
    }
}

1;
