#!/usr/bin/perl

#save best posse pdb from each cluster from autodock VS. 
#command line: download_VS_BestFromCluster.pl .dlg outputprefix

use warnings;
use strict;

my $openfile = $ARGV[0];
my $out = $ARGV[1];

my $outfile = "allcluster_$out.pdb"; #outputname
unless(open PDB, ">$outfile"){die "\n Unable to create $outfile\n";}

unless(open DLG, "<$openfile"){die "\n Unable to open $openfile\n";}

	while (my $line=<DLG>){
		if ($line=~/USER.*Cluster Rank.*/) {
			while ($line!~/ENDMDL.*/){$line=<DLG> and print PDB $line;
			}
		}
	}	

close PDB and close DLG and print "   Done!! :) \n   Check allcluster_$out.pdb file \n";
