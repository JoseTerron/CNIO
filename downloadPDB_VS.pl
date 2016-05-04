#!/usr/bin/perl

#save pdb of different clusters from autodock. 
#write in command line: perl downloadclusters.pl numberofcluster .dlg outputname

use warnings;
use strict;

my $cluster = $ARGV[0];
shift @ARGV; #take out the left value of the array then the second (file) is now the first
my $openfile = $ARGV[0];
my @list; my $Element;
shift @ARGV;
my $out = $ARGV[0];

my $outfile = "cluster$cluster-$out.pdb"; #outputname
unless(open PDB, ">$outfile"){die "\n Unable to create $outfile\n";}

unless(open DLG, "<$openfile"){die "\n Unable to open $openfile\n";}

while (<DLG>) {
	if ($_ =~ /.*RMSD TABLE.*/) {
		while ($_ !~ /.*INFORMATION ENTROPY.*/){
			$_ = <DLG>;
			if ($_ =~ /   $cluster\s+\d+\s+(\d+).*/) {
				push @list, "$1";
				}
			}
		}
	}


while(scalar(@list) !=0){
	$Element=shift(@list);
	seek DLG, 0, 0;
	while (<DLG>){
		if ($_ =~ /DOCKED: (.*Run = $Element\s+.*)/) {
#			print PDB "$1\n";
			while ($_ =~ /DOCKED: (.*)/){$_ = <DLG>; print PDB "$1\n";}
		}
	}	
}

print "   Done!! :) \n   Check cluster$cluster-$out.pdb file \n";
