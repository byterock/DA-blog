package DA_S;
use lib qw(D:\GitHub\DA-blog\lib);

BEGIN {
  $DA_S::VERSION = "0.01";
}

 use Data::Dumper;
use Moose;


has lsd_driver => (
    default  => 'DA::LSD',
    is   => 'rw',
   
);

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
   my $lsd;
   if ($conn eq 'DBH'){
     use DA_S::LSD::SQL;
     $lsd = DA_S::LSD::SQL->new(DA=>$self);
   }
   elsif ($conn eq 'MONGO'){
        use DA_S::LSD::Mongo;
    $lsd = DA_S::LSD::Mongo->new(elements=>$self->elements,view=>$self->view);   

   }
   
   return $lsd->_execute("retrieve",$conn,$container,$opt);
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




# __PACKAGE__->meta->make_immutable;
1;

