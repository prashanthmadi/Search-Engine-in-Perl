#!usr/bin/perl -w
use strict;
system("perl spider.pl > output");

         print("this will print 4000 links into output\n");

system("perl gettingfiles.pl output > docsandlinks");

        print("this will get all the files related to links in output into a new folder corpus and a new file which has filename in corpus followed by its link name\n");

system("perl computingforeachdoc.pl corpus/ htmltagremoved html_tagremove.pl");

          print("this will take input folder and puts tags removed documents in new folder htmltagremoved\n");

system("perl computingforeachdoc.pl htmltagremoved/ tokenizedout newtoken.pl");

         print("this will put tokenized output data in tokenzedout of each file in htmltagremoved\n");

system("rm -rf corpus/");

system("perl computingforeachdoc.pl tokenizedout/ porterout porter_stemmer.pl");

         print("this will put porterstemmer output of each document in tokenizedout into porterout\n");

system("rm -rf htmltagremoved/");

system("perl computingforeachdoc.pl porterout/ wordfreqout wordfrequency.pl");

        print("this will put the frequency of words in each file of porterout in wordfereqout\n");

system("rm -rf tokenizedout/");

system("perl stopwordremovalforeachdoc.pl wordfreqout/ stopwordout stopwordremoval.pl stopwords");

        print("this will remove all the stopwords and punctuations from each document and places output files in stopwordout\n");

system("rm -rf porterout/");
system("rm -rf wordfreqout/");
system("perl tf_idf.pl stopwordout/");

      print("this will generate tfidf of each document and stores them in tfidf folder\n");
      print("it also generates a storing_doc_distance file which has the distance measure of each document for measuring similarity between documents\n");
      print("it also generates inverted which keeps track of all the words present in which documents with second column consisting of the total number of documents for that\n");

system("rm -rf stopwordout/");

#system("perl similaritybweachdoc.pl tfidf/ storing_doc_distance");

       #this will compare each input file with other and puts similarity measure in a folder similarity_docs. This would be useful for clustering documents
        #here it is and adjacency matrix so i would calculate only half i.e 2->1 wont exist as i have 1->2 which would be the same

