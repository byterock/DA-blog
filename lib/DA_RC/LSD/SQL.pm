package DA_RC::LSD::SQL;

BEGIN {
    $DA_RC::LSD::SQL::VERSION = "0.01";
}
use lib qw(D:\GitHub\DA-blog\lib);
use Moose::Role;
with qw(DA::Roles::API);



sub _execute {
    my $self = shift;
    my ( $da,$connection, $container, $opts ) = @_;
    my $delimiter = " ";
    my $sql       = "SELECT ";
    foreach my $element ( @{  $da->elements() } ) {

        $sql .= $delimiter . $element->retrieve();

        $delimiter = ", ";

    }

     return   $sql ." FROM ". $da->view()->retrieve();

}


sub ping {
    my $self = shift;
    return 'Ping';
}


1;
