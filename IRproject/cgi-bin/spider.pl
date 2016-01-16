        # usage: perl filename
	# author :  Prashanth Reddy madi 

 require LWP::UserAgent;
 my %hashlinks; 
 my @link_array;
 my $counter=0;
 my $i=1;
 $link_array[0]="http://www.unt.edu/";  # enter the weblink from where you want to start
 my $ua = LWP::UserAgent->new;

sub links_extractor
{ 
 my($link_processed)=@_;
 $ua->timeout(10);
 $ua->env_proxy;
 my $response = $ua->get("$link_processed"); 
 if ($response->is_success)
 {
  my $inter=$response->decoded_content;  # storing the data in html file into variable
  @totalines=split/\n/,$inter;
  foreach $line(@totalines)
   { 
     $line=~m/href="([^>]*)>/g;
     $link=$1;
     $link=~m/([^"#]*)/g;
     $link1=$1;
     my $z;     
     my @split_link=split/\//,$link_processed;
   # print $link_processed."\t"; 
    if($split_link[$#split_link]=~m/./)       
    { 
     if($#split_link>2)
     {
       pop(@split_link);
      }
     }
       $z=join "/",@split_link;
      if($link1!~m/http/g)
      {
      my @res=split/\//,$link1;
      if($res[0] ne "..")
      {
      $link1=~s/^[[:punct:]]+//;
      }
      $z=~s/\/$//;
      $link1="$z/$link1";
   #   print "---".$link1."\n";
   #    print $link1."\n";
      }
     if($link1=~m/translate.google.com/g)
        {
        next;                          # this is to eliminate google translater
        }				# this consists of unt.edu
	my @robot_exception=split/\//,$link1;
	if($robot_exception[3]=~m/bulkmail|remedy|stats|webstats/g)  # setting the constraints for robot
	{
	next;
	}

      if($link1=~m/unt.edu/g)		# this is to take consider the webpages under unt domain
      {
       if($link1!~m/mailto/) 		# eliminate href values containing mailto
       {

        my @remove_css=split/\//,$link1;
        my @last=split//,$link1;
        if($last[$#last] ne "/")
        {
 	if($remove_css[$#remove_css]!~m/(.htm|.html)/)
	{
	next;
	}
       }
	if(exists $hashlinks{$link1})	# check whether the link already exists. this to eliminate duplicates
	{
	next;
	}
	else
	{
	$link_array[$i]=$link1;		#storing non-redundant links in a array to display output
	$i++;
	if($i==4000)
	{
	$counter=1;			# this is to consider first 1000 links
	}
	}
	$hashlinks{$link1}++;		# storing the links into an hash to eliminate redundancy
#       print $link1."\n";
       }
      }
    }
  }
 else
 {
# print $link_processed."\n";
  next;
 
# die $response->status_line;
 }
  return @link_array;			# returning array consisting of non-redundant links
}


=pod
foreach my $key(keys %hashlinks)
{
print $key."\n";
}
=cut


my @links;
foreach my $key(@link_array)
{
 if($counter==1)
 {
 last;
 }
@links=&links_extractor($key);			# this will call the subroutine to extract links untill counter becomes 1
}

for($key=1;$key<$#links;$key++)
{
print "$links[$key]"."\n";				# printing the output
}
