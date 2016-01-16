#!/usr/bin/perl
# Sample CGI interface for a search engine
# Rada, 04/25/2006 
use CGI;

##=============== VARIABLES YOU MIGHT NEED TO CHANGE======================
# Set this to the working directory
$workingDir = "/home/prm0080/public_html/CGI-Sample/cgi-bin";
# Set this to the name of your search-engine program
$clustering="/home/prm0080/public_html/CGI-Sample/cgi-bin/directclusterin.pl";
#==========================================================================



## CALL THE SEARCH ENGINE
$query = new CGI; 
$time = time();

# read the query from the Web interface
$myQuery = $query->param("QUERY");

# run my search engine and collect the results
# - the query read from the Web interface is stored in $myQuery
# - the search engine returns a list of documents, which is
# stored in @myResults
#undef($myResults);
my @myResults = `perl $clustering tfidf/ querysearchresult 0.6  docsandlinks storing_doc_distance`;
my $myResults1 = join "<br>",@myResults;


## DISPLAY THE RESULTS AND THE QUERY FIELD 
print $query->header ( ); 
print <<END_HTML; 

<HTML> 
<HEAD> 
<TITLE>My Cool Search Engine!</TITLE> 
<SCRIPT LANGUAGE="JAVASCRIPT">

<!-- BEGIN HIDE

	function reviewInput(f)
		{
		var goAhead=false;
		var maxLength=30000;
		var i;

		if (f.QUERY.value.length<1) {
		    alert("Please complete all fields");
		}
		else {
                    goAhead = true;
                }
		return goAhead;

		}  // END function reviewInput

	//  END HIDE -->

</SCRIPT>
</HEAD> 

<BODY BGCOLOR="#FFFFFF" TEXT="#000000" VLINK="#0000FF" ALINK="#000000" LINK="#CC0033">

<FORM ENCTYPE="multipart/form-data" METHOD="POST" NAME="queryForm" ACTION="wordnet.cgi">

<TABLE WIDTH="600" BORDER="0" CELLPADDING="10" CELLSPACING="5">

	<TR><TH BGCOLOR="FF3030" COLSPAN="3"><FONT SIZE="5" COLOR=WHITE FACE="ARIAL,HELVETICA">SEARCH & CLUSTER</FONT></TH></TR>

	<TR>
	        <TD COLSPAN="3">
		<FONT SIZE="-1" FACE="ARIAL,HELVETICA">

	<TR>
		<TD COLSPAN="3">
		<FONT SIZE="-1" FACE="ARIAL,HELVETICA">

                 <B> The clustered documents for the query "$myQuery" are: </B> <BR>

<h4> $myResults1</h4>

</TD>
</TR>
		
 
	<TR>
		<TD COLSPAN="3" ALIGN="CENTER">
		<FONT SIZE="-1" FACE="ARIAL,HELVETICA">

                 


		<!-- BEGIN FOOTER -->
		<HR SIZE="1" NOSHADE>
		<P ALIGN="CENTER">

		</FONT>
		</TD>
	</TR>
        
 

</TABLE>
</FORM>

</BODY>

</HTML> 

END_HTML

 

