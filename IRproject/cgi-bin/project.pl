#!usr/bin/perl -w
use strict;
open(my $outdata,">query");
foreach my $indata(@ARGV)
{
print $outdata $indata." ";
}



system("perl newtoken.pl query > querytoken");

#print("this will print tokenized data in query to querytoken\n");

system("perl porter_stemmer.pl querytoken > querystem");

#print("this will print porter stemmer output of querytoken into querystem\n");

system("perl wordfrequency.pl querystem > queryfreq");

#print("this will print frequency of each term into queryfrq file\n");

system("perl stopwordremoval.pl queryfreq stopwords > querystop");

#          this will print the data in queryfreq removing stopwords


system("perl comparing.pl inverted querystop storing_doc_distance tfidf/ docsandlinks");

#print("watch out for search result in querysearchresult\n");

#system("perl clustering.pl similarity_docs/ querysearchresult 0.6  docsandlinks");

#         this will cluster documents based on query and puts the result in clusteredlinks file
 #    this program does clustering based on previously calculated similarity between each documents


#system("perl directclusterin.pl tfidf/ querysearchresult 0.6  docsandlinks storing_doc_distance");

#print("watch for clustered links in drectclusteredlinks\n");

