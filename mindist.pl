#!/usr/bin/perl

#set frames that are asociated with the same number
#command line: mindist.pl .txt (with frames_numbers) number

use warnings;
use strict;

my $goal = $ARGV[0];
my $openfile = $ARGV[1];
my $start; my $end;

unless(open FILE, "<$openfile"){die "\n Unable to open $openfile\n";}

my $outfile = "frames_$goal.txt";
unless(open OUTFILE, ">$outfile"){die "\n Unable to open $outfile\n";}

while(<FILE>){
	if ($_ =~ /(.*)_$goal.*/){
		$start = $1;
		while ($_ =~ /(.*)_$goal.*/) {$_=<FILE> and $end=$1;}
		print  OUTFILE "$start $end\n";
		}
}

print "   Done!! :) \n Check $outfile file \n";

close FILE and close OUTFILE;
