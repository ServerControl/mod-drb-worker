#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:

package ServerControl::Module::DrbWorker;

use strict;
use warnings;

our $VERSION = '0.94';

use ServerControl::Module;
use ServerControl::Commons::Process;

use base qw(ServerControl::Module);

__PACKAGE__->Implements( qw(ServerControl::Module::PidFile) );

__PACKAGE__->Parameter(
   help  => { isa => 'bool', call => sub { __PACKAGE__->help; } },
);

sub help {
   my ($class) = @_;

   print __PACKAGE__ . " " . $ServerControl::Module::DrbWorker . "\n";

   printf "  %-30s%s\n", "--name=", "Instance Name";
   printf "  %-30s%s\n", "--path=", "The path where the instance should be created";
   printf "  %-30s%s\n", "--user=", "DRB User";
   printf "  %-30s%s\n", "--group=", "DRB Group";
   print "\n";
   printf "  %-30s%s\n", "--create", "Create the instance";
   printf "  %-30s%s\n", "--start", "Start the instance";
   printf "  %-30s%s\n", "--stop", "Stop the instance";

}

sub start {
   my ($class) = @_;

   my $pid_dir     = ServerControl::FsLayout->get_directory("Runtime", "pid");

   my ($name, $path)    = ($class->get_name, $class->get_path);
   my $env_conf  = ServerControl::FsLayout->get_file("Configuration", "environment");
   my $exec_file = ServerControl::FsLayout->get_file("Exec", "DrbWorker");

   open(my $conf, "<", $env_conf) or die($!);
   while( my $line = <$conf>) {
      my ($key, $val) = split(/=/, $line, 2);
      $ENV{$key} = $val;
   }
   close($conf);

   spawn("$path/$exec_file start");
}


1;
