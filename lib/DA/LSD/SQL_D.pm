package DA::LSD::SQL_D;

BEGIN {
    $DA::LSD::SQL_D::VERSION = "0.01";
}
use lib qw(D:\GitHub\DA-blog\lib);
use Moose::Role;
with qw(DA::Roles::API);


sub _execute {
    my $self = shift;
    my ( $connection, $container, $opts ) = @_;
    my $delimiter = " ";
    my $sql       = "SELECT ";

    foreach my $element ( @{ $self->DA->elements() } ) {

        $sql .= $delimiter . $element->sql();

        $delimiter = ", ";

    }

    return   $sql ." FROM ". $self->DA->view()->sql();

}


sub ping {
    my $self = shift;
    return 'Ping';
}


1;
