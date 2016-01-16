        # usage: perl filename file1
        # file1 has links 
	# author :  Prashanth Reddy madi 
#!usr/bin/perl 
 require LWP::UserAgent;
 use Encode;
 my %hashlinks; 
 my $infile=$ARGV[0];
 my @link_array;
 my $counter=0;
 my $i=1;
my $ua = LWP::UserAgent->new;
my $counter=0;
=pod
sub links_extractor
{ 
 my($link_processed)=@_;
 $ua->timeout(10);
 $ua->env_proxy;
 my $response = $ua->get("$link_processed"); 
 if ($response->is_success)
 {
  $counter++;
  my $inter=$response->decoded_content;  # storing the data in html file into variable
  $inter = decode_utf8($inter);
# print $inter."\n";
#$inter = decode_utf8( $inter );
 print "document$counter"."\t";
 print "$link_processed"."\n";
 open(my $outdata,">corpus/document$counter");
 print $outdata $inter; 
 }
 else
 {
  next;
 # die $response->status_line;
 }
}
=cut

open(my $indata,"$infile");
mkdir("corpus");
while(<$indata>)
{
my $link=$_;
chomp($link);
 $ua->timeout(1000);
 $ua->env_proxy;
 my $response = $ua->get("$link");
 if ($response->is_success)
 {
  $counter++;
  my $inter=$response->decoded_content;  # storing the data in html file into variable
#  $inter = decode_utf8($inter);
# print $inter."\n";
#$inter = decode_utf8( $inter );
 print "document$counter"."\t";
 print "$link"."\n";
 open(my $outdata,">corpus/document$counter");
 print $outdata $inter;
 }
 else
 {
  next;
 # die $response->status_line;
 }

#last;
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
