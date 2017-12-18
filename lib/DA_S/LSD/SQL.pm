package DA_S::LSD::SQL;

BEGIN {
    $DA_RC::LSD::SQL::VERSION = "0.01";
}
use lib qw(D:\GitHub\DA-blog\lib);
use Moose;
with qw(DA::Roles::API);
use MooseX::ClassAttribute;
use DA_S::LSD kind => 'DA';


sub _execute {
    my $self = shift;
    my ( $da,$connection, $container, $opts ) = @_;
    my $delimiter = " ";
    my $sql       = "SELECT ";
    foreach my $element ( @{  $self->DA->elements() } ) {

        $sql .= $delimiter . $element->retrieve();

        $delimiter = ", ";

    }

     return   $sql ." FROM ". $self->DA->view()->retrieve();

}


sub ping {
    my $self = shift;
    return 'Ping';
}


1;
