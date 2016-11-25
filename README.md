# CCP::Xero
Perl CPAN style module to simplify integration with Xero API Applications

Inspired by the Xero endorsed Ruby API Library https://github.com/waynerobinson/xeroizer/ 
and the CPAN Net::Xero module, this Perl module aims to simplify integration with Xero API Applications
points for Public, Private and in the future Partner application services.
CCP::Xero modules primarily encapsulate the OAuth (v1.0a) access control.



## Prerequisites 
Perl and a Xero API Application
build tools ( make etc )
````sh
sudo apt-get install perl build-essential ## eg debian package install
````

## Getting Started

This Perl code is in the standard CPAN package format and can be installed using the usual approach:
```sh
    perl Makefile.PL
    make
    make test
    make install
```

### Installing Step by Step

Download the source:

```sh
    git clone https://github.com/pscott-au/CCP-Xero
    cd CCP-Xero
```

Create the makefile

```sh
perl Makefile.PL
```
If given notice of missing dependency modules, these can be installed from CPAN. For example to install a missing Crypt::OpenSSL::RSA module:
```sh
    sudo perl -MCPAN -e "install Crypt::OpenSSL::RSA"
```

NB: Crypt::OpenSSL::RSA from CPAN requires SSL devel libraries which
    can be installed as follows:
```sh 
  apt-get install libssl-dev ## for debian etc
  yum install openssl-dev    ## for RH,Centos, Ubuntu etc
```
Make,test and install the library
```sh
make
make test
make install
```

## Usage

An example of a basic agent accessing a private Xero Application.
````perl
#!/usr/bin/perl
use strict;
use warnings;
use CCP::Xero::Agent::PrivateApplication;
use Data::Dumper;

my $xero = CCP::Xero::Agent::PrivateApplication->new( CONSUMER_KEY    => 'YOUR_OAUTH_CONSUMER_KEY', 
                                                    CONSUMER_SECRET => 'YOUR_OAUTH_CONSUMER_SECRET', 
                                                    KEYFILE         => "/path/to/privatekey.pem" 
                                                          );
## AND THEN ACCESS THE API POINTS
my $contact_struct = $xero->do_xero_api_call( 'https://api.xero.com/api.xro/2.0/Contacts' );
print Dumper $contact_struct; ## should contain an array of hashes containing contact data.
````

See perldoc for details
````sh
perldoc CCP::Xero
````
