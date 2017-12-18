package DA::Roles::API;

BEGIN {
  $ DA::Roles::API::VERSION = "0.01";
}



use Moose::Role;
requires '_execute';

1;

