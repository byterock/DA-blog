package Database::Accessor::DAD::SQL;

BEGIN {
    $Database::Accessor::DAD::SQL::VERSION = "0.01";
}
use lib qw(D:\GitHub\DA-blog\lib);
use Moose;
with (qw( Database::Accessor::Roles::DAD));

sub Execute {
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

sub DB_Class {
    my $self = shift;
    return 'DBI::db';
}



1;
