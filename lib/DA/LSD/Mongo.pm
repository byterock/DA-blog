package DA::LSD::Mongo;

BEGIN {
    $DA::Mongo::VERSION = "0.01";
}
use lib qw(D:\GitHub\DA-blog\lib);
use Moose::Role;
#with qw(DA::Roles::API);
sub _execute {
    my $self = shift;
    my ( $connection, $container, $opts ) = @_;
    my $delimiter = " ";
    my $sql       = "db.";

    $sql .= $self->view()->name();
    $sql .= ".find({},{";

    foreach my $element ( @{ $self->elements() } ) {

        $sql .= $delimiter . $element->name() . ": 1";
        $delimiter = ", ";

    }
    $sql .= "}";

    return $sql;

}

sub pong {
    my $self = shift;
    return 'Pong';
}

1;
