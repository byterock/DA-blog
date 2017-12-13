#!perl 
use Test::More 0.82;
use Test::Fatal;

use lib ('D:\GitHub\DA-blog\lib');
use Test::More tests => 12;

BEGIN {
    use_ok('DA_D');
    use_ok('DA::View');
    use_ok('DA::Element');
}

my $view = DA::View->new(
    {
        name  => 'person',
        alias => 'me'
    }
);
ok( ref($view) eq 'DA::View', "Person is a View" );
my $street = DA::Element->new( { name => 'street', } );
ok( ref($street) eq 'DA::Element', "Street is an Element" );
my $country = DA::Element->new( { name => 'country', } );
ok( ref($country) eq 'DA::Element', "County is an Element" );
my $city = DA::Element->new( { name => 'city', } );
ok( ref($city) eq 'DA::Element', "City is an Element" );
my @elements = ( $street, $city, $country );

my $address = DA_D->new(
    {
        view     => $view,
        elements => \@elements
    }
);

ok( ref($address) eq 'DA_D', "Address is a DA_D" );
ok(
    $address->retrieve( 'DBH', $result ) eq
      'SELECT  street, city, country FROM person  AS me',
    'SQL correct'
);

eval{
     $address->ping();
     fail("address can ping");
};
if ($@) {
    pass("Address cannot do a ping");
};

eval{
     $address->pong();
     fail("address can pong");
};
if ($@) {
    pass("Address cannot do a pong");
};


ok(
    $address->retrieve('MONGO') eq
      'db.person.find({},{ street: 1, city: 1, country: 1}',
    "Mongo Query correct"
);

eval{
     $address->ping();
     fail("address can ping");
};
if ($@) {
    pass("Address cannot do a ping");
};

eval{
     $address->pong();
     fail("address can pong");
};
if ($@) {
    pass("Address cannot do a pong");
};





