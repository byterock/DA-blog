package DA_SC;
use lib qw(D:\GitHub\DA-blog\lib);

BEGIN {
  $DA_SC::VERSION = "0.01";
}

 use Data::Dumper;
use Moose;


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
   my $driver;
   if ($conn eq 'DBH'){
     $driver= "DA_SC::LSD::SQL";
   }
   elsif ($conn eq 'MONGO'){
     $driver= "DA_SC::LSD::Mongo";
   }
   my $lsd = DA_SC::LSD::build_instance(
                    package => "LSD::$conn",
                    superclasses =>['DA_SC::LSD'],
                    roles =>[$driver,'DA::Roles::API'],
                    view=>$self->view,
                    elements=>$self->elements     );
   
   
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

    package 
           DA_SC::LSD;
           use Data::Dumper;
    use Moose;
    use MooseX::ShortCut::BuildInstance qw(  build_instance should_re_use_classes);
    should_re_use_classes( 1 );# To reuse build_instance
    
    has view => (
    is     => 'ro',
    isa    => 'Object',
);

has elements  => (
    isa  => 'ArrayRef',
    is      => 'ro',
);
    sub pop {
    my $self = shift;
    warn("pop=".ref($self));
    return 'Pop';
 }
1;



# __PACKAGE__->meta->make_immutable;
1;

