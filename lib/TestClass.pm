 
 use Test::More;
use Test::Moose::More 0.014;
use Moose::Util::TypeConstraints 'class_type';
 
use MooseX::Types::Moose ':all';
 package TestClass;
 
    use Moose;
    use namespace::autoclean;
 
    with 'MooseX::RelatedClasses' => {
        names => [ qw{ Baz Bar Boo } ],
    };

{ package TestClass::Baz; use Moose; use namespace::autoclean }
{ package TestClass::Bar; use Moose; use namespace::autoclean }
{ package TestClass::Boo; use Moose; use namespace::autoclean }

# BEGIN {
  # $DA_RC::VERSION = "0.01";
# }

# use Moose;
 # use namespace::autoclean;
 # with 'MooseX::RelatedClasses' => {
         # names => [qw {View Element}],
     # };
 
 # with 'MooseX::RelatedClasses' => {
        # name => 'Elements',
    # };
 
# has view => (
    # is     => 'rw',
    # isa    => 'Object',
# );

# has elements  => (
    # isa  => 'ArrayRef',
    # is      => 'rw',
# );

# sub retrieve {
   # my $self=shift;
   # my ($conn,$container,$opt) = @_;
   
   # if ($conn eq 'DBH'){
       # apply_all_roles( $self, "DA::LSD::SQL");

   # }
   # elsif ($conn eq 'MONGO'){
       # apply_all_roles( $self, "DA::LSD::Mongo");

   # }
   # die "LSD $conn must use DA::Roles::API"
    # if (!does_role($self,'DA::Roles::API'));
    
   # return $self->_execute("retrieve",$conn,$container,$opt);
# }

 
# {
    # package 
           # DA::View;
    # use Moose;

    # has 'name' => (

        # required => 1,
        # is     => 'rw',
        # isa      => 'Str'

    # );

    # has 'alias' => (

        # is     => 'rw',
        # isa      => 'Str'

    # );

  # sub sql {
        # my $self = shift;
        # if ( $self->alias() ) {
            # return $self->name() . "  AS " . $self->alias();
        # }
        # else {
            # return $self->name();
        # }
    # }
  # }
# {
  # package 

           # DA::Element;

    # use Moose;


    # has 'name' => (
        # required => 1,
        # isa      => 'Str',
        # is     => 'rw',
    # );
    # has 'alias' => (
        # isa      => 'Str',
        # is     => 'rw',
    # );
    # sub sql {
        # my $self = shift;
        # if ( $self->alias() ) {
            # warn('JSO '.$self->name() . "  AS " . $self->alias());
            # return $self->name() . "  AS " . $self->alias();
        # }
        # else {
            # return $self->name();
        # }
    # }
# }


1;

