#!perl 
use Test::More 0.82;
use Test::Fatal;

use lib ('D:\GitHub\DA-blog\lib');
use Test::More tests => 3;

BEGIN {
    use_ok( 'DA_ABC::Memory' ) || print "Bail out!
";
}


use_ok("DA_ABC","can use DA_ABC");


like(exception { DA_ABC->new() }, qr/ DA_ABC is abstract, it cannot be instantiated/,
     "instantiating abstract classes fails");
