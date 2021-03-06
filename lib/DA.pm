package DA;

BEGIN {
  $DA::VERSION = "0.01";
}

use Moose;
 use Moose::Util qw(apply_all_roles does_role);
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
   
   if ($conn eq 'DBH'){
       apply_all_roles( $self, "DA::LSD::SQL");

   }
   elsif ($conn eq 'MONGO'){
       apply_all_roles( $self, "DA::LSD::Mongo");

   }
   die "LSD $conn must use DA::Roles::API"
    if (!does_role($self,'DA::Roles::API'));
    
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

__PACKAGE__->meta->make_immutable;
1;

