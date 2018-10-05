#!C:/perl/bin/perl.exe
##
## Copyright (C) 2008 Michel D. Schmid <michaelschmid@users.sourceforge.net>
##
##
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2, or (at your option)
## any later version.
##
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; see the file COPYING.  If not, see
## <http://www.gnu.org/licenses/>.

use strict;
use diagnostics;    # Force verbose warning diagnostics.
use warnings;
use English;

#use vars qw( $VERSION );
#use Getopt::Long;
#use Win32;
use Win32::Process;
use Win32::Console::ANSI;
use Term::ANSIScreen qw/:color /;


#my $command = "D:\\programs\\programming\\octave\\bin\\octave.exe";
my $args = "D:\\programs\\programming\\octave\\bin\\octave.exe D:\\daten\\octave\\neuroPackage\\0.1.8.1\\nnet\\tests\\nnetTest.m";
my $numberOfFailedTests = 0;
my $numberOfSuccessfullTests = 0;
my $testingFile;
my @tokens=[];
#my $process; # Prozess-Objekt
print "Starting with tests for the neural network package\n";
# Win32::Process::Create($process,
# 					   $command,
# 					   $args,
# 					   1,
# 					   CREATE_NEW_CONSOLE,
# 					   '.');
#$process->Wait(INFINITE); # script will wait until process is finished

# my $pid = $process->GetProcessID();
# print "new process pid: $pid\n";
open(COUNTER, "$args |")
or die("...: $!\n");

while (<COUNTER>)
{
   if (/^testing/)
   {
     chomp ($testingFile = $_);
   }
   if (/^!!!!!/)
   {
     $numberOfFailedTests += 1;
     print colored("$testingFile $_",'red');
   }elsif(/^PASSES/)
   {
     @tokens = split(/ /, $_);
     $numberOfSuccessfullTests += $tokens[4];
     print colored("$testingFile $_",'yellow');
   }

}
print "\n\n";
print colored("Summary:\n",'green');
print colored("Number of files containing failed tests: $numberOfFailedTests!\n",'red');
print colored("Number of successfull tests:             $numberOfSuccessfullTests!\n",'yellow');
my $allTests = $numberOfFailedTests + $numberOfSuccessfullTests;
print colored("\nRunning complete $allTests tests!\n",'green');

close COUNTER;





