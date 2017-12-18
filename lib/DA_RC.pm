package DA_RC;
use lib qw(D:\GitHub\DA-blog\lib);

BEGIN {
  $DA_RC::VERSION = "0.01";
}

 use Data::Dumper;
use Moose;
has lsd_driver => (
    default  => 'DA::LSD',
    is   => 'rw',
   
);

 with 'MooseX::RelatedClassRoles' => { name => 'DA::LSD', class_accessor_name=>'lsd_driver',apply_method_name   => 'install_lsd', };
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
     
     $self->install_lsd("DA_RC::LSD::SQL");
   }
   elsif ($conn eq 'MONGO'){
     $self->install_lsd("DA_RC::LSD::Mongo");
   }
   
   return $self->lsd_driver->_execute($self,"retrieve",$conn,$container,$opt);
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
            warn('JSO '.$self->name() . "  AS " . $self->alias());
            return $self->name() . "  AS " . $self->alias();
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

    sub pop {
    my $self = shift;
    warn("pop=".ref($self));
    return 'Pop';
}

}

# __PACKAGE__->meta->make_immutable;
1;

