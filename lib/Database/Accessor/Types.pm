{
package Database::Accessor::Types;
use Moose::Role;

use lib qw(D:\GitHub\DA-blog\lib);
use Moose::Util::TypeConstraints;
use Database::Accessor::View;

class_type 'View',  { class => 'Database::Accessor::View' };


coerce 'View', from 'HashRef', via { Database::Accessor::View->new( %{$_} ) };

1;
}
