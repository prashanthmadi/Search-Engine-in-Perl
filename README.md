# Clustering Search Results #
### Prashanth Reddy Madi ###
### (_prm0080@unt.edu_) ###

## Abstract: ##
Web creates new challenges as amount of information on the
web is growing rapidly, as well as the number of new users inexperienced in the art of
web research. People are likely to surf the web using its link graph, often starting with
high quality human maintained indices such as search engine. Many of times, Each
output link from search engine depicts different topic, Ex: Apple (company, fruit). In
order to direct user with one of the topic, Showing User's Similar pages (Requires
Clustering) at regular interval's for their query (reformulated based on cluster in use)
may reduce this effect. Common method of clustering includes BOW(bag of words)
model. These are based on co-occurrence statistics which ignores semantic relatedness.
Usage of semantic relatedness involve computational complexity. With growing web
pages, It's almost became practically impossible with limited resources. In this paper, we
present a naive implementation of Clustering method. I had also eliminated totally
similar pages, as they represent same information.





Please find the complete code in Downloads

This a serach Engine written in perl. for first 3000 links on a domain. you can customize the code and have as many links as possible and u can limit the search engine to a particular domain.





<br><br><br><br>
searching for scholarship<br>
<br><br><br><br>
<img src='https://search-engine-perl.googlecode.com/files/scholarship.png' />
<br><br><br><br>
Results i got for the scholarship keyword<br>
<br><br><br><br>
<img src='https://search-engine-perl.googlecode.com/files/scholarship_result.png' />
<br><br><br><br>
My extension to cluster results (similar type data in links)<br>
<br><br><br><br>
<img src='https://search-engine-perl.googlecode.com/files/scholarship_clust.png' />
<br><br><br><br>
My extension to use wordnet to extend query<br>
<br><br><br><br>
<img src='https://search-engine-perl.googlecode.com/files/scholarship_wordnet.png' />
<br><br><br><br>
My extension to use wordnet to extend query based on geographical location. Below is query extension for query <i>paris</i>
<br><br><br><br>
<img src='https://search-engine-perl.googlecode.com/files/paris_wordnet.png' />