package Database::Accessor::DAD::SQL;

BEGIN {
    $Database::Accessor::DAD::SQL::VERSION = "0.01";
}
use lib qw(D:\GitHub\DA-blog\lib);
use Moose;
with(qw( Database::Accessor::Roles::DAD));

sub Execute {
    my $self = shift;
    my ( $da, $connection, $container, $opts ) = @_;
    my $delimiter = " ";
    my $sql       = "SELECT ";
    foreach my $element ( @{ $self->Elements() } ) {
        $sql .= $delimiter . $self->element_sql($element);

        $delimiter = ", ";

    }
    return $sql . " FROM " . $self->element_sql($self->View());

}

sub DB_Class {
    my $self = shift;
    return 'DBI::db';
}

sub element_sql {
    my $self      = shift;
    my ($element) = @_;
    if ( $element->alias() ) {
        return $element->name() . "  AS " . $element->alias();
    }
    else {
        return $element->name();
    }
}
1;
