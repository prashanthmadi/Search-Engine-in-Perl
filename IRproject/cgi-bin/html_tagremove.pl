# this will take input file and removes tags and anything between <script> from the html file

# usage : perl filename htmlfile
#!usr/bin/perl 
my $file1=$ARGV[0];
undef($/);
open(my $indata,"$file1");
while(<$indata>)
{
my $line=$_;
$line=~s/\n/ /g;
$line=~s/<script[^>]*>.*?<\/script>//igs;
$line=~s/<[^>]*>/ /g;
$line=~s/\s+/ /g;
print $line."\n";
}
