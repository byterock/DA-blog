
#!perl 
{
  package DBI::db;
 sub new {
    my $class = shift;

    my $self = {};
    bless( $self, ( ref($class) || $class ) );

    return( $self );

}
 

}
{
  package MongoDB::Collection;
 sub new {
    my $class = shift;

    my $self = {};
    bless( $self, ( ref($class) || $class ) );

    return( $self );

}


}             

use Test::More 0.82;
use Test::Fatal;
use Data::Dumper;
use lib ('D:\GitHub\DA-blog\lib');
use Test::More tests => 9;
use Moose::Util qw(apply_all_roles does_role with_traits);
use Time::HiRes;

BEGIN {
    use_ok('Database::Accessor');
}


my $address = Database::Accessor->new(
    {
        view     => {name  => 'person',
                     alias => 'me'},
        elements => [{ name => 'street', },
                     { name => 'city', },
                     { name => 'country', } ]
    }
);

eval {
   $address->view($street);
  };
   if ($@) {
       
      pass("Can only take a View Class");
   }
   else {
       fail("Takes a non View Class");
   }

ok( ref($address->view()) eq 'Database::Accessor::View', "View is a Database::Accessor::View" );

foreach my $element (@{$address->elements()}){
    ok( ref($element) eq 'Database::Accessor::Element', "Element ".$element->name()." is a Database::Accessor::Element" );
    
}    

ok( ref($address) eq 'Database::Accessor', "Address is a Database::Accessor" );
my $fake_dbh = DBI::db->new();

ok(
    $address->retrieve( $fake_dbh, $result ) eq
      'SELECT  street, city, country FROM person  AS me',
    'SQL correct'
);
my $fake_mongo = MongoDB::Collection->new();

ok(
    $address->retrieve($fake_mongo) eq
      'db.person.find({},{ street: 1, city: 1, country: 1}',
    "Mongo Query correct"
);




