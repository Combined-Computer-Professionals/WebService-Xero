package WebService::Xero::ContactPerson;

use Moose;
 
has 'FirstName'       => (is => 'rw');
has 'LastName'        => (is => 'rw');
has 'EmailAddress'    => (is => 'rw');
has 'IncludeInEmails' => (is => 'rw');



sub TO_JSON
{
  my ( $self ) = @_;
  return {
    FirstName => $self->{FirstName},
    LastName => $self->{LastName},
    EmailAddress => $self->{EmailAddress},
    IncludeInEmails => $self->{IncludeInEmails}
  }
}

1;
