/*http://listserv.uga.edu/cgi-bin/wa?A2=ind0410b&L=sas-l&F=P&S=&P=14313
Chang

*/


%macro sort_sql(wordlist=);

/*-- quick and dirty list sort
  usage example:
%let sortedlist=;
%sort(wordlist=d b c)
%put ***&sortedlist.***;


  works only in the open and on windows platform.
--*/

   filename in pipe "@echo &wordlist.";
   data;
      infile in dlm=" ";
      input word :$32767. @@;
   run;
   proc sql noprint;
      select word into :sortedlist separated by " "
      from   _last_
      order by word
      ;
   quit;
%mend;

