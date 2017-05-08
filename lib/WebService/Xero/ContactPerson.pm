package WebService::Xero::ContactPerson;

use Moose;
 
has 'FirstName'       => (is => 'rw');
has 'LastName'        => (is => 'rw');
has 'EmailAddress'    => (is => 'rw');
has 'IncludeInEmails' => (is => 'rw');

1;
