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

        $sql .= $delimiter . $element->retrieve();

        $delimiter = ", ";

    }

    return   $sql ." FROM ". $self->DA->view()->sql();

}


sub ping {
    my $self = shift;
    return 'Ping';
}

{
  package 
     DA::LSD::SQL_D::Element;
  use Moose::Role;
  sub retrieve {
        my $self = shift;
        if ( $self->alias() ) {
            return $self->name() . "  AS " . $self->alias();
        }
        else {
            return $self->name();
        }
    }
}
1;
