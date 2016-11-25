# CCP::Xero
Perl CPAN style module to simplify integration with [Xero API Applications](https://developer.xero.com)

Inspired by the Xero endorsed Ruby API Library [Xeroizer] 
and the CPAN [Net::Xero](http://search.cpan.org/~elliott/Net-Xero-0.43/lib/Net/Xero.pm) module, this Perl module aims to simplify integration with Xero API Applications
points for Public, Private and in the future Partner application services.
CCP::Xero modules primarily encapsulate the [OAuth (v1.0a) access control protocol as described by Cubrid](http://www.cubrid.org/blog/dev-platform/dancing-with-oauth-understanding-how-authorization-works/) .
The module is in the CCP namespace because it was extracted from a larger application.



## Prerequisites 

* Perl
* build tools ( make etc )
* Xero API Application with credentials as descibed in the [Xero Developer Getting Started Guide](https://developer.xero.com/documentation/getting-started/getting-started-guide/)

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

### Todos

 - Classes for all Xero Components ( Item, Contact, Invoice etc )
 - Working Public Application Example 
 - Partner Application Interface

LICENSE AND COPYRIGHT
----

Copyright 2016 Peter Scott.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

http://www.perlfoundation.org/artistic_license_2_0

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


### Development Support

Want to contribute? Great, get in touch!
Need some help with your setup - will try to help where I can.


[Xeroizer]: <https://github.com/waynerobinson/xeroizer/README.md>
  

