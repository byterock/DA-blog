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

