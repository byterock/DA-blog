package DA_AM;

BEGIN {
  $DA::VERSION = "0.01";
}

use Moose;
use  MooseX::AbstractMethod;

abstract '_execute';

sub retrieve {
   my $self=shift;
   my ($conn,$container,$opt) = @_;
   return $self->_execute("retrieve",$conn,$container,$opt);
}

1;

