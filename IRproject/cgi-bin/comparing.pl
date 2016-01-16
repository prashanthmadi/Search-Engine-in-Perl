#!usr/bin/perl -w
use strict;
my $invertedind=$ARGV[0];
my $queryfile=$ARGV[1];
my $doc_dist_file=$ARGV[2];
my $corpus_folder=$ARGV[3];
my $docslink=$ARGV[4];
my $limiting=0;
open(my $invertdata,"$invertedind");
my %df_word;
my %indexed_doc;
while(<$invertdata>)
{
my $line=$_;
my @words=split/\s+/,$line;
$df_word{$words[0]}=$words[1];
my $firstword=$words[0];
shift(@words);
shift(@words);                       # this is to make inverted index
my $i=0;
 foreach my $word(@words)
 {
  $indexed_doc{$firstword}[$i]=$word;
  $i++;
 }
}

my $documentscount=0;
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

my %queryhash;
my @query;
open(my $querydata,"$queryfile");
while(<$querydata>)
{
my $line=$_;
chomp $line;
my @splittedline=split/\s+/,$line; # taking in query data
push(@query,$splittedline[1]);
my $query_tf=$splittedline[0];
my $query_idf=0;
  if(exists $df_word{$splittedline[1]})
  {
   $query_idf=log($documentscount/$df_word{$splittedline[1]})/log(2);
  }
  else
  {
   $query_idf=1;
  }
$queryhash{$splittedline[1]}=$query_tf*$query_idf;
}

my %query_rel_docs;
for my $word(@query)
{
my $temp=$#{$indexed_doc{$word}}+1;
   for my $doc(0..$#{$indexed_doc{$word}})   # this is to choose documents for query
   {
    my $querydocs=$indexed_doc{$word}[$doc];
    $query_rel_docs{$querydocs}++;
    }
}


my %similarity_mes;
#opendir(DIR,"$corpus_folder");
my %corpushash;
foreach my $doc(sort keys %query_rel_docs)
{
my $corpusdoc="document$doc";
#print $corpusdoc." ";
open(my $corpusdata,"$corpus_folder/$corpusdoc");
 while(<$corpusdata>)
 {
 my $line=$_;
 chomp $line;
 my @splitted_line=split/\s+/,$line;
 $corpushash{$splitted_line[1]}=$splitted_line[0];
 }

 my $numerator=0;
 my $denominator;
 foreach my $query_word(keys %queryhash)
 {
#print $query_word."\n";
  if(exists $corpushash{$query_word})
  {
   $numerator+=$corpushash{$query_word}*$queryhash{$query_word};
  }
 }
 $denominator=$doc_distance{$corpusdoc}*1.414;
 $similarity_mes{$corpusdoc}=$numerator/$denominator;
#print $similarity_mes{$corpusdoc}."\n";
}
#print "\n";

my @sorted = sort { $similarity_mes{$b} cmp $similarity_mes{$a} } keys %similarity_mes; 

my %link;
open(my $linking,"$docslink");
open(my $outlinks,">outputofsortedlinks");
while(<$linking>)
{
my $line=$_;
my @splittedline=split/\s+/,$line;
$link{$splittedline[0]}=$splittedline[1];
}

open(my $outdata,">querysearchresult");
foreach my $sortdoc(@sorted)
{
print "\<a href=$link{$sortdoc}\>$link{$sortdoc}\<\/a\>"."\n";
#.$similarity_mes{$sortdoc}."\n";
$limiting++;
if($limiting<40)
{
print $outdata $sortdoc."\t".$similarity_mes{$sortdoc}."\n";
}
}
