#!usr/bin/perl -w
use strict;
my $inputdir=$ARGV[0];
my $outputdir=$ARGV[1];
my $executablefile=$ARGV[2];
mkdir("$outputdir");
opendir(DIR,"$inputdir");
#opendir(out,"$outputdir");
my @total_dirfiles=readdir(DIR);
foreach my $inputfile(@total_dirfiles)
{
 if($inputfile eq "." || $inputfile eq "..")
 {
 next;
 }


system("perl $executablefile $inputdir/$inputfile > $outputdir/$inputfile");

}
