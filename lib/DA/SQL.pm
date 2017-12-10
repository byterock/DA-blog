package DA::SQL;

BEGIN {
    $DA::SQL::VERSION = "0.01";
}
use lib qw(D:\GitHub\DA-blog\lib);
use Moose;
with 'DA';

sub _execute {
    my $self = shift;
    my ( $connection, $container, $opts ) = @_;
    my $delimiter = " ";
    my $sql       = "SELECT ";

    foreach my $element ( @{ $self->elements() } ) {

        $sql .= $delimiter . $element->sql();

        $delimiter = ", ";

    }

    return   $sql ." FROM ". $self->view()->sql();

}

1;
