            # usage perl filename.pl file1 file2
	    # file1 is the inputfile consisting the data from which stopwords should be eliminated
            #  file2 is has set of stopwords
#!usr/bin/perl -w
my $inputfile=$ARGV[0];
my $stopwords=$ARGV[1];
open(my $infile,"$inputfile");
while(<$infile>)
{
my $line=$_;
my @splitted_array=split/\t/,$line;
chomp($splitted_array[1]);
#print $splitted_array[1];
if($splitted_array[1]=~m/[[:punct:]]/)
{
next;
}
  undef($/);
  open(my $stop,"$stopwords");
  while(<$stop>)
  {
   my $stop_words=$_;
      $stop_words=~s/\n/ /g;
	if($stop_words=~m/$splitted_array[1]/g)
	{
	next;
	}
	else
	{
	print $line;
	}
  }
  $/="\n";
}
