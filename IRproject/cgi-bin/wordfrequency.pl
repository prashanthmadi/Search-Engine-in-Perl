  # usage perl wordfrequency.pl inputfile > outputfile
  # inputfile is the output of tokenizer
  # outputfile has each word associated with frequency of occurance 
#!usr/bin/perl -w
use strict;
my $infile=$ARGV[0];
my %totalwords;
my @data;
my $line;
open(my $indata,"$infile");
while(<$indata>)
{
$line=$_;
@data=split/\s/,$line;
}
foreach my $word(@data)
{
$totalwords{$word}++;
}
sub hashValueDescendingNum {
   $totalwords{$b} <=> $totalwords{$a};
}

foreach my $key (sort hashValueDescendingNum (keys(%totalwords))) {
   print "$totalwords{$key} \t $key\n";
}


