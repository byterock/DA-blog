package DA_SC::LSD::Mongo;

BEGIN {
    $DA_SC::Mongo::VERSION = "0.01";
}
use lib qw(D:\GitHub\DA-blog\lib);
use Moose::Role;
with (qw( DA::Roles::LSD));

sub _execute {
    my $self = shift;
    my ( $da,$connection, $container, $opts ) = @_;
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

sub connection_class {
    my $self = shift;
    return 'MongoDB::Collection';
}
 sub pong {
    my $self = shift;
    return 'Pong';
}

1;
