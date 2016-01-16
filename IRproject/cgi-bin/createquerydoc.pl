#!usr/bin/perl -w
use strict;
open(my $outdata,">query");
foreach my $indata(@ARGV)
{
print $outdata $indata." ";
}
