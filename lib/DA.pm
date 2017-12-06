package DA;

BEGIN {
  $DA::VERSION = "0.01";
}

use Moose::Role;

requires '_execute';

sub retrieve {
   my $self=shift;
   my ($conn,$container,$opt) = @_;
   return $self->_execute("retrieve",$conn,$container,$opt);
}

1;

