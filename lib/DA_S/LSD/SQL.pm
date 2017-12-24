package DA_S::LSD::SQL;

BEGIN {
    $DA_S::LSD::SQL::VERSION = "0.01";
}
use lib qw(D:\GitHub\DA-blog\lib);
use Moose;
with qw(DA_S::Roles::API);
use MooseX::ClassAttribute;
use DA_S::LSD elements=>'elements', view=>'view';



sub _execute {
    my $self = shift;
    my ( $da,$connection, $container, $opts ) = @_;
    my $delimiter = " ";
    my $sql       = "SELECT ";
    foreach my $element ( @{  $self->elements() } ) {

        $sql .= $delimiter . $element->retrieve();

        $delimiter = ", ";

    }

     return   $sql ." FROM ". $self->view()->retrieve();

}

sub connection_class {
    my $self = shift;
    return  'DBI::db';
}

sub ping {
    my $self = shift;
    return 'Ping';
}


1;
