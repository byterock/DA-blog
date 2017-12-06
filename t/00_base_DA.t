#!perl 
use Test::More 0.82;
use Test::Fatal;

use lib ('D:\GitHub\DA-blog\lib');
use Test::More tests => 3;

BEGIN {
    use_ok( 'DA::Memory' ) || print "Bail out!
";
}

use_ok("DA","can use DA");


like(exception { DA->new() }, qr/Can't locate object method "new" via packag/,
     "Cannot Instantiate a Role");



