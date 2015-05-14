/*
%put %get_label(sashelp.iris,SepalLength);
*/

%macro get_label(data,variable);
	%local label;  
   	%let dsid = %sysfunc(open(&data));
	%let dnum=%sysfunc(varnum(&dsid,&variable));

  	%if &dsid %then %do;
         %let label=%sysfunc(varlabel(&dsid,&dnum));
         %let rc = %sysfunc(close(&dsid));		
   	%end;
    &label;
%mend;  