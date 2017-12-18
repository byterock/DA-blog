    package 
           DA_S::LSD;
           use Data::Dumper;
    use Moose;
     use MooseX::Scaffold;
MooseX::Scaffold->setup_scaffolding_import;

sub SCAFFOLD {
    my $class = shift; 
    my %given = @_;
    $class->has($given{kind} => is=>'ro', isa=>'Object', required=>1)
      if (exists($given{kind}) );
    
    $class->has(elements => is=>'ro', isa=>'ArrayRef', required=>1) 
         if (exists($given{elements} ));
    
    $class->has(view => is=>'ro', isa=>'Object', required=>1) 
         if (exists($given{view} ));
}

    sub pop {
    my $self = shift;
    warn("pop=".ref($self));
    return 'Pop';
 }
1;
