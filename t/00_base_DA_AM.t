#!perl 
use Test::More 0.82;
use Test::Fatal;

use lib ('D:\GitHub\DA-blog\lib');
use Test::More tests => 4;

BEGIN {
    use_ok( 'DA_AM::Memory' ) || print "Bail out!";
}

my $new=DA_AM::Memory->new();
#ok($new->meta->make_immutable);
like(
        exception { $new->meta->make_immutable },
        qr/abstract methods have not been implemented/,
        'DA_AM::Memory dies requires _execute sub',
    );

#ok($new->retrieve());
diag( "Testing DA::Memory  $DA::Memory::VERSION, Perl $], $^X" );

use_ok("DA_AM","can use DA");

my $daa=DA_AM->new();

ok(ref($daa) eq 'DA_AM',"Directly opened DA");
