#!usr/bin/perl -w
use strict;
my $inputdir=$ARGV[0];
open(my $doc_dist,">storing_doc_distance");
my %documentfrequency;
my %index;
opendir(DIR,"$inputdir");
my @total_dirfiles=readdir(DIR);
my $documentscount=@total_dirfiles-2;     # reducing by 2 to eliminate . and ..
foreach my $inputfile(@total_dirfiles)
{
 if($inputfile eq "." || $inputfile eq "..")
 {
 next;
 }
  open(my $input,"$inputdir/$inputfile");
  while(<$input>)
 {
  my $x=0;
  my $line=$_;
  my @linevalues=split/\s+/,$line;
  $documentfrequency{$linevalues[1]}++;
  $x=$documentfrequency{$linevalues[1]}-1;
  my $short=$inputfile;
  $short=~s/[[:alpha:]]//g;
  $index{$linevalues[1]}[$x]=$short;
 # print $linevalues[1]." ";
 }
}
#my @words= keys % documentfrequency;

my %termfrequency;
my $outputdir="tfidf";
mkdir("$outputdir");
foreach my $infile(@total_dirfiles)
{
 if($infile eq "." || $infile eq "..")
 {
 next;
 }
  my $square_tfidf=0;
  my $count=0;
  my $doc_maxvalue=0;
  open(my $output,">$outputdir/$infile");
  open(my $input,"$inputdir/$infile");

 print $doc_dist $infile."\t";
 
 while(<$input>)
  {
   my $line=$_;
   my @linevalues=split/\s+/,$line;
   if($count==0)
   {
   $doc_maxvalue=$linevalues[0];
   $count++;
   }
   my $normalized_tf=$linevalues[0]/$doc_maxvalue;
   my $idf= log($documentscount/$documentfrequency{$linevalues[1]})/log(2);
   my $tfidf= $normalized_tf * $idf;
   print $output $tfidf."\t";
   print $output $linevalues[1]."\n";
   $square_tfidf+=$tfidf*$tfidf;
   
  }
 my $root_tfidf= sqrt($square_tfidf);
 print $doc_dist $root_tfidf."\n";
}

open(my $invert,">inverted");
for my $word(keys %index){
my $temp=$#{$index{$word}}+1;
print $invert $word." ".$temp." ";
   for my $doc(0..$#{$index{$word}})
   {
    print $invert $index{$word}[$doc]." ";
    }
 print $invert "\n";
}
