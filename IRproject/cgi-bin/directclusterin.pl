#!usr/bin/perl -w
use strict;
my $infolder=$ARGV[0];
#open(DIR,"$infolder");
my $searchresult=$ARGV[1];
my $limit=$ARGV[2];
my $docslink=$ARGV[3];
my $doc_dist_file=$ARGV[4];
my @searchdocs;
my %search_sim_hash;
open(my $searchdata,"$searchresult");
while(<$searchdata>)
{
my $line=$_;
my @splittedline=split/\s+/,$line;
$splittedline[0]=~s/[[:alpha:]]//g;
push @searchdocs,$splittedline[0];
}


# below code will keep track distance of each doc

my %doc_distance;
open(my $doc_dist,"$doc_dist_file");
while(<$doc_dist>)
{
my $line=$_;
#$documentscount++;
my @linedata=split/\s+/,$line;
$doc_distance{$linedata[0]}=$linedata[1];
}

my @cluster;
$cluster[0][0]=$searchdocs[0];
shift(@searchdocs);
foreach my $doc(@searchdocs)
{
my $acc=0;
 foreach my $row(0..$#cluster)
 {
   my $x=$cluster[$row][0];
   my $y=$doc;
   if($cluster[$row][0]>$doc)
   {
     $x=$doc;
     $y=$cluster[$row][0];
   }
   my $similarity;
   my $file_1="document$x";
   my $file_2="document$y";
   if($doc_distance{$file_1}==0||$doc_distance{$file_2}==0)
   {
    $similarity=0;
   }
   else
   { 
    $similarity=&measuresimilarityofdocs($x,$y); 
   }
   if((1-$similarity)<$limit)
   {
         if((1-$similarity)<0.1)
	{
         $acc=1;
	 last;
	}
     $cluster[$row][$#{$cluster[$row]}+1]=$doc;
     $acc=1;
    last;
    }
  } 
  if($acc==0)
  {
   $cluster[$#cluster+1][0]=$doc; 
  }
}

sub measuresimilarityofdocs
{
my($file1,$file2)=@_;
my $file_1="document$file1";
 my $file_2="document$file2";
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

  open(my $file2data,"$infolder/$file_2");
  while(<$file2data>)
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
 my $similarity=$numerator/$denominator;
 return($similarity);
}

### printing clusters 
### print links rather than docs.:)

open(my $outdata,">directclusteredlinks");
my %link;
open(my $linking,"$docslink");
while(<$linking>)
{
my $line=$_;
my @splittedline=split/\s+/,$line;
$link{$splittedline[0]}=$splittedline[1];
}

foreach my $item1(@cluster)
{
  print "\>";
  foreach my $item2 (@{$item1})
  {
    $item2="document$item2";
#    print $outdata " $link{$item2}\n";  
    print "\<a href=$link{$item2}\> $link{$item2}\<\/a\>\n";  
  }
  print "\n";
}

