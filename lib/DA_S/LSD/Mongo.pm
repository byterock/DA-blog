package DA_S::LSD::Mongo;

BEGIN {
    $DA::Mongo_D::VERSION = "0.01";
}
use lib qw(D:\GitHub\DA-blog\lib);
use Moose;
with qw(DA::Roles::API);
use MooseX::ClassAttribute;
use DA_S::LSD elements=>'elements', view=>'view';

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

 sub pong {
    my $self = shift;
    return 'Pong';
}

1;
