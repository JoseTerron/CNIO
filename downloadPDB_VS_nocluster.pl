#!/usr/bin/perl

#save pdb of all posses from autodock .dlg  
#command line: downloadPDB_VS_nocluster.pl .dlg outputname_prefix

use warnings;
use strict;

my $openfile = $ARGV[0];
shift @ARGV;
my $out = $ARGV[0];

my $outfile = "$out.pdb"; #outputname
unless(open PDB, ">$outfile"){die "\n Unable to create $outfile\n";}

unless(open DLG, "<$openfile"){die "\n Unable to open $openfile\n";}

	while (<DLG>){
		if ($_ =~ /DOCKED: (.*Run = \d+\s+.*)/) {
			while ($_ =~ /DOCKED: (.*)/){$_ = <DLG> and print PDB "$1\n";}
		}
	}	

print "   Done!! :) \n   Check $out.pdb file \n";

close PDB and close DLG;
