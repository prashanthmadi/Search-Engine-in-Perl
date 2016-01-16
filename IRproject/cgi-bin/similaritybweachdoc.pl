# this perl script will compare each and everydocument in that folder and outputs their similarity in another file
# usage perl filename inputdir doc_distance

#!usr/bin/perl -w
use strict;
my $infolder=$ARGV[0];
my $doc_dist_file=$ARGV[1];
my $documentscount=0;
my %similarityhash;
# below code will keep track distance of each doc
my %doc_distance;
open(my $doc_dist,"$doc_dist_file");
while(<$doc_dist>)
{
my $line=$_;
$documentscount++;
my @linedata=split/\s+/,$line;
$doc_distance{$linedata[0]}=$linedata[1];
}

mkdir("similarity_docs");
opendir(DIR,"$infolder");
my @totalfiles=readdir(DIR);
my $filecount=$#totalfiles-2;
foreach my $file1(135..$filecount)
{
open(my $outdata,">similarity_docs/$file1");
 foreach my $file2($file1..$filecount)
 {
 my $file_1="document$file1";
 my $file_2="document$file2";
 if($doc_distance{$file_1}==0||$doc_distance{$file_2}==0)
 {
  $similarityhash{$file_1}{$file_2}=0;
  print $outdata $file1." ".$file2." ".$similarityhash{$file_1}{$file_2}."\n";
 next;
 }
 my %corpushash1;
 my %corpushash2;
  open(my $file1data,"$infolder/$file_1");
  while(<$file1data>)
  {
   my $line=$_;
   chomp $line;
   my @splitted_line=split/\s+/,$line;
   $corpushash1{$splitted_line[1]}=$splitted_line[0];
  }

  open(my $file1data,"$infolder/$file_2");
  while(<$file1data>)
  {
   my $line=$_;
   chomp $line;
   my @splitted_line=split/\s+/,$line;
   $corpushash2{$splitted_line[1]}=$splitted_line[0];
  }
  my $numerator=0;
  my $denominator=1;
  foreach my $word(keys %corpushash1)
  {
    if(exists $corpushash2{$word})
    {
    $numerator+=$corpushash1{$word}*$corpushash2{$word};
    }  
  }
  $denominator=$doc_distance{$file_1}*$doc_distance{$file_2};
  $similarityhash{$file_1}{$file_2}=$numerator/$denominator;

  print $outdata $file1." ".$file2." ".$similarityhash{$file_1}{$file_2}."\n";
 }
}
