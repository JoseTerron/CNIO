#!/usr/bin/perl

#save best posse pdb from autodock VS. 
#command line: perl download_VS_BEST.pl .dlg outputnameprefix

use warnings;
use strict;

my $openfile = $ARGV[0];
my $out = $ARGV[1];

my $outfile = "allcluster_$out.pdb"; #outputname
unless(open PDB, ">$outfile"){die "\n Unable to create $outfile\n";}

unless(open DLG, "<$openfile"){die "\n Unable to open $openfile\n";}

	while (my $line=<DLG>){
		if ($line=~/USER.*Cluster Rank = 1.*/) {
			while ($line!~/ENDMDL.*/){$line=<DLG>; print PDB $line;
			}
		}
	}	

close PDB and close DLG and print "   Done!! :) \n   Check allcluster_$out.pdb file \n";
