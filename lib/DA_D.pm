package DA_D;

BEGIN {
  $DA_D::VERSION = "0.01";
}

use Moose;
 use Moose::Util qw(apply_all_roles does_role with_traits);
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
   my $lsd = DA::LSD->new(DA=>$self);
   if ($conn eq 'DBH'){
      apply_all_roles( $lsd, "DA::LSD::SQL_D");
      foreach my $elememt (@{$self->elements()}) {
           apply_all_roles( $elememt, "DA::LSD::SQL_D::Element");
       }
   }
   elsif ($conn eq 'MONGO'){
      apply_all_roles( $lsd, "DA::LSD::Mongo_D");

   }
  die "LSD $conn must use DA::Roles::API"
    if (!does_role($lsd,'DA::Roles::API'));
   return $lsd->_execute("retrieve",$conn,$container,$opt);
}
__PACKAGE__->meta->make_immutable;
 
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
    
    has retrieve1=>(
       isa =>'Str',
       is  =>'rw',
       lazy=>1,
       builder=> '_element_retrieve'
    
    );
    sub sql {
        my $self = shift;
        if ( $self->alias() ) {
            return $self->name() . " AS " . $self->alias();
        }
        else {
            return $self->name();
        }
    }
}


{
    package 
           DA::LSD;
    use Moose;
     
    has DA => (
       is     => 'rw',
       isa    => 'Object',
    );
    

}

1;

