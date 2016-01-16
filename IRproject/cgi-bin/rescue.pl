#usr/bin/perl -w
use strict;
my $file=$ARGV[0];
undef($/);
open(my $indata,"$file");
while(<$indata>)
{
my $line=$_;
$line=~s/\n/ /g;
print $line;
}
