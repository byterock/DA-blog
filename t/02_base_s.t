#!perl 
use Time::HiRes;
#use Benchmark qw(:hireswallclock);
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
use Test::More tests => 10;
use Moose::Util qw(apply_all_roles does_role with_traits);
BEGIN {
   
    use_ok('DA_S');
    use_ok('DA::View');
    use_ok('DA::Element');
}
my $bm_s =  Time::HiRes::gettimeofday();
#my $bm_s = Benchmark->new ;
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


my $address = DA_S->new(
    {
        view     => $view,
        elements => \@elements
    }
);


ok( ref($address) eq 'DA_S', "Address is a DA_S" );
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
my $bm_e =  Time::HiRes::gettimeofday();

#my $bm_e = Benchmark->new;

printf("I ran in %.8f s\n", $bm_e - $bm_s);
# my $diff = timediff($bm_e,$bm_s );
# print "the code took:",timestr($diff),"\n";
# print "the code took:",timestr($bm_s),"\n";
 # print "the code took:",timestr($bm_e),"\n";
