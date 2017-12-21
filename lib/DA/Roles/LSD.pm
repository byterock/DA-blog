package DA::Roles::LSD;
BEGIN {
  $DA::Roles::LSD::VERSION = "0.01";
}
use Moose::Role;
requires 'connection_class';
1;

