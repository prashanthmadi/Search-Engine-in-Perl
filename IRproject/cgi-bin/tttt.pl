        # usage: perl filename file1
        # file1 has links 
	# author :  Prashanth Reddy madi 
#!usr/bin/perl 
 my %hashlinks; 
 my $infile=$ARGV[0];
 my @link_array;
 my $i=1;
 my $counter=0;
=pod
sub links_extractor
{ 

 my($link_processed)=@_;
open my $fh,"curl $link_processed|";
       {
         local $/;
         $var=<$fh>;
       

  $counter++;
 print "document$counter"."\t";
 print "$link_processed"."\n";
 open(my $outdata,">corpus/document$counter");
 print $outdata $var; 
}
}
=cut
open(my $indata,"$infile");
mkdir("corpus");
while(<$indata>)
{
my $link=$_;
chomp($link);

# my($link_processed)=@_;
open my $fh,"curl $link|";
       {
         local $/;
         $var=<$fh>;


  $counter++;
 print "document$counter"."\t";
 print "$link_processed"."\n";
 open(my $outdata,">corpus/document$counter");
 print $outdata $var;
}

}



=pod

my @links;
foreach my $key(@link_array)
{
 if($counter==1)
 {
 last;
 }
chomp($key);
@links=&links_extractor($key);			# this will call the subroutine to extract links untill counter becomes 1
}

for($key=1;$key<$#links;$key++)
{
print "$links[$key]"."\n";				# printing the output
}

=cut
