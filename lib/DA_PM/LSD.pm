    package 
           DA_SC::LSDxx;
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
