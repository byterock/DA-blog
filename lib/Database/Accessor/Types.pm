{
package Database::Accessor::Types;
use Moose::Role;

use lib qw(D:\GitHub\DA-blog\lib);
use Moose::Util::TypeConstraints;
use Database::Accessor::View;
use Database::Accessor::Element;

class_type 'View',  { class => 'Database::Accessor::View' };
class_type 'Element',  { class => 'Database::Accessor::Element' };

subtype 'ArrayRefofElements' => as 'ArrayRef[Element]';

coerce 'View', from 'HashRef', via { Database::Accessor::View->new( %{$_} ) };

coerce 'ArrayRefofElements', from 'ArrayRef', via {
    [ map { Database::Accessor::Element->new($_) } @$_ ];
};

1;
}
