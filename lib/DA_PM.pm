package DA_PM;
use lib qw(D:\GitHub\DA-blog\lib);

BEGIN {
  $DA_PM::VERSION = "0.01";
}

use Data::Dumper;
use File::Spec;
use Moose;
use Moose::Util qw(does_role);

sub BUILD {
    my $self = shift;
    map { $self->_loadLSDClassesFromDir($_) }
      grep { -d $_ } map { File::Spec->catdir($_, 'DA_PM','LSD' ) } @INC;

}

sub _loadLSDClassesFromDir {
    my $self = shift;
    my ($path) = @_;
    
    opendir(DIR, $path) or die "Unable to open $path: $!";
    
    my @files = grep { !/^\.{1,2}$/ } readdir(DIR);
    # Close the directory.
    closedir(DIR);

    @files = map { $path . '/' . $_ } @files;
    
    my $lsd;
    for (@files) {
        # If the file is a directory
        if (-d $_) {

            # using a new directory we just found.
        }
        elsif (/.pm$/) { #we only care about pm files
            my ($volume, $dir, $file) = File::Spec->splitpath($_);
            $file =~ s{\.pm$}{};    # remove .pm extension
            $dir =~ s/^.+Replay\/Rules\///;
           
            # my $_package = join '::' => grep $_ => File::Spec->splitdir($dir);
            # my $skipname = join '_' => grep $_ => File::Spec->splitdir($dir);
            
          
            # # untaint that puppy!
           
            # my ($package) = $_package =~ /^([[:word:]]+(?:::[[:word:]]+)*)$/;
             my $classname = "";
            
        
            # if ($package) {
                # $classname = join '::', 'DA_SC', 'LSD', $package, $file;
                # $skipname  = join '_',$skipname, $file;
            # }
            # else {
                $classname = join '::', 'DA_PM', 'LSD', $file;
                # $skipname  = $skipname.'_'.$file;
            # }

            eval  "require $classname";

            if ($@) {
                my $err = $@;
                my $advice
                    = "DA/LSD/$file ($classname) may not be an DA LSD!\n\n";
                warn(
                    "\n\n Load of DA/LSD/$file.pm failed: \n   Error=$err \n $advice\n");
                next;
            }
            else {
                next
                  unless (does_role($classname,'DA_PM::Roles::LSD'));    #now only loads this class
warn("--->Got here classname=".Dumper($classname->connection_class));
#                  my $lsd =$classname->new();
               $lsd->{$classname->connection_class} =$classname;
            }

        }
      
    }
    $self->_lsds($lsd)
      if (keys($lsd))
        
        
}


has _lsds =>(
    isa  => 'HashRef',
    is      => 'rw',
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
   
   my $drivers = $self->_lsds();
   my $driver =  $drivers->{ref($conn)};
   
   die "No LSD loaded for ".ref($conn). " Maybe you have to load a DSL for it?"
     unless($driver);
   
   my $lsd = $driver->new({view=>$self->view,
                          elements=>$self->elements});
   
   
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


package DA_PM::Roles::LSD;
BEGIN {
  $DA_PM::Roles::LSD::VERSION = "0.01";
}
use Moose::Role;
requires 'connection_class';
requires '_execute';

has view => (
    is     => 'ro',
    isa    => 'Object',
);

has elements  => (
    isa  => 'ArrayRef',
    is      => 'ro',
);

1;



1;



# __PACKAGE__->meta->make_immutable;
1;

