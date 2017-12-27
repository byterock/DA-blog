package Database::Accessor;
use lib qw(D:\GitHub\DA-blog\lib);

BEGIN {
  $Database::Accessor::VERSION = "0.01";
}

use Data::Dumper;
use File::Spec;
use Moose;
use Moose::Util qw(does_role);

sub BUILD {
    my $self = shift;
    map { $self->_loadDADClassesFromDir($_) }
      grep { -d $_ } map { File::Spec->catdir($_, 'Database','Accessor' ) } @INC;

}

sub _loadDADClassesFromDir {
    my $self = shift;
    my ($path,$dad) = @_;
    $dad = {}
      if (ref($dad) ne 'HASH');
    opendir(DIR, $path) or die "Unable to open $path: $!";
    
    my @files = grep { !/^\.{1,2}$/ } readdir(DIR);
    # Close the directory.
    closedir(DIR);

    @files = map { $path . '/' . $_ } @files;
   
    for (@files) {
        # If the file is a directory
        if (-d $_) {
           $self->_loadDADClassesFromDir($_,$dad);
            # using a new directory we just found.
        }
        elsif (/.pm$/) { #we only care about pm files
            my ($volume, $dir, $file) = File::Spec->splitpath($_);
            $file =~ s{\.pm$}{};    # remove .pm extension
            $dir =~ s/^.+Database\/Accessor\///;
            my $_package = join '::' => grep $_ => File::Spec->splitdir($dir);
            # # untaint that puppy!
            my ($package) = $_package =~ /^([[:word:]]+(?:::[[:word:]]+)*)$/;
            my $classname = "";
        
             if ($package) {
                 $classname = join '::', 'DA_SC', 'LSD', $package, $file;
             }
             else {
                $classname = join '::','Database', 'Accessor', 'DAD', $file;
             }
            eval  "require $classname";

            if ($@) {
                my $err = $@;
                my $advice
                    = "Database/Accessor/DAD/$file ($classname) may not be an Database Accessor Driver (DAD)!\n\n";
                warn(
                    "\n\n Load of Database/Accessor/DAD/$file.pm failed: \n   Error=$err \n $advice\n");
                next;
            }
            else {
                next
                  unless (does_role($classname,'Database::Accessor::Roles::DAD'));    #now only loads this class
               $dad->{$classname->DB_Class} = $classname;
            }

        }
      
    }
    $self->_ldad($dad)
      if (keys($dad))
        
        
}


has _ldad =>(
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
   
   my $drivers = $self->_ldad();
   my $driver =  $drivers->{ref($conn)};
   
   die "No Database::Accessor::Driver loaded for ".ref($conn). " Maybe you have to install a Database::Accessor::DAD::?? for it?"
     unless($driver);
   
   my $dad = $driver->new({view=>$self->view,
                          elements=>$self->elements});
   
   
   return $dad->Execute("retrieve",$conn,$container,$opt);
}


{
    package 
          Database::Accessor::View;
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
        Database::Accessor::Element;

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


package Database::Accessor::Roles::DAD;
BEGIN {
  $DA_PM::Roles::LSD::VERSION = "0.01";
}

use Moose::Role;
requires 'DB_Class';
requires 'Execute';

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

