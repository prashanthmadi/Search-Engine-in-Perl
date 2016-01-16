#!usr/bin/perl -w
use strict;
my $infolder=$ARGV[0];
#open(DIR,"$infolder");
my $searchresult=$ARGV[1];
my $limit=$ARGV[2];
my $docslink=$ARGV[3];
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

foreach my $doc(@searchdocs)
{
 open(my $sim_mes,"$infolder/$doc");
  while(<$sim_mes>)
  {
   my $line=$_;
   my @splittedline=split/\s+/,$line;
   $search_sim_hash{$splittedline[0]}{$splittedline[1]}=$splittedline[2];
   }
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
   if((1-$search_sim_hash{$x}{$y})<$limit)
   {
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

### printing clusters 
### print links rather than docs.:)

open(my $outdata,">clusteredlinks");
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
  print ">";
  foreach my $item2 (@{$item1})
  {
    $item2="document$item2";
    #print $outdata " $link{$item2}\n";  
    print " $link{$item2}\n";  
  }
  print "\n";
}

