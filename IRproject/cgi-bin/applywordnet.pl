my $infile=$ARGV[0];
open(my $indata,"$infile");
while(<$indata>)
{
$y=$_;
}
#print $y."\n";
 require "QueryData.pm";

  my $wn = WordNet::QueryData->new("dict");
#$y=join(' ',@ARGV);
print $y." ";
my @yy=split/\s+/,$y;
foreach $x(@yy)
 {
my @each_word;
    
   my $synsout=join(" ", $wn->querySense("$x#n#1","syns"));
     $synsout=~s/\#.\#\d//g;
#print $synsout."\n";
   my @syn_word=split/\s/,$synsout;
my $counter=0;
      push(@each_word,@syn_word);
    my $holoout=join(" ", $wn->querySense("$x#n#1","holo"));
     $holoout=~s/\#.\#\d//g;
 #   print $holoout."\n";
    my @holo_word=split/\s/,$holoout;
      push(@each_word,@holo_word);
    my $mprtout=join(" ", $wn->querySense("$x#n#1","mprt"));
     $mprtout=~s/\#.\#\d//g;
 # print $mprtout."\n";
   my @mprt_word=split/\s/,$mprtout;
 foreach $y(@yy)
   {
    if($mprtout=~m/$y/ig)
     {
     $counter=1;
     }
   }
   if($counter==0)
  {
      push(@each_word,@mprt_word);
  }
   for my $out(@each_word)
   {
   print $out." ";
    }

 }
print "\n";
