package DA_S::Roles::API;

BEGIN {
  $ DA_S::Roles::API::VERSION = "0.01";
}



use Moose::Role;
requires '_execute';

1;

