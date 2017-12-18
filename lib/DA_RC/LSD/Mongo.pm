package DA_RC::LSD::Mongo;

BEGIN {
    $DA::Mongo_D::VERSION = "0.01";
}
use lib qw(D:\GitHub\DA-blog\lib);
use Moose::Role;
with qw(DA::Roles::API);


sub _execute {
    my $self = shift;
    my ( $da,$connection, $container, $opts ) = @_;
    my $delimiter = " ";
    my $sql       = "db.";

    $sql .= $da->view()->name();
    $sql .= ".find({},{";

    foreach my $element ( @{ $da->elements() } ) {

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
