package DA;

BEGIN {
  $DA::VERSION = "0.01";
}

use Moose::Role;

requires '_execute';


has view => (
    is     => 'rw',
    isa    => 'Object',
);

has elements  => (
    isa  => 'ArrayRef',
    is      => 'rw',
);

sub retrieve {
   my $self=shift;
   my ($conn,$container,$opt) = @_;
   return $self->_execute("retrieve",$conn,$container,$opt);
}

 
{
    package 
           DA::View;
    use Moose;

    has 'name' => (

        required => 1,
        is     => 'rw',
        isa      => 'Str'

    );

    has 'alias' => (

        is     => 'rw',
        isa      => 'Str'

    );

  sub sql {
        my $self = shift;
        if ( $self->alias() ) {
            return $self->name() . "  AS " . $self->alias();
        }
        else {
            return $self->name();
        }
    }
  }
{
  package 

           DA::Element;

    use Moose;


    has 'name' => (
        required => 1,
        isa      => 'Str',
        is     => 'rw',
    );
    has 'alias' => (
        isa      => 'Str',
        is     => 'rw',
    );
    sub sql {
        my $self = shift;
        if ( $self->alias() ) {
            warn('JSO '.$self->name() . "  AS " . $self->alias());
            return $self->name() . "  AS " . $self->alias();
        }
        else {
            return $self->name();
        }
    }
}
1;

