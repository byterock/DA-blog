package DA_SC::LSD::SQL;

BEGIN {
    $DA_SC::LSD::SQL::VERSION = "0.01";
}
use lib qw(D:\GitHub\DA-blog\lib);
use Moose::Role;
with (qw( DA::Roles::LSD));

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
    return 'DBI::db';
}


sub ping {
    my $self = shift;
    return 'Ping';
}


1;
