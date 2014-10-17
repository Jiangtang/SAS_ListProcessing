


%macro get_type(ds,var);
	%let dsid = %sysfunc(open(&ds,i));
	%let dnum=%sysfunc(varnum(&dsid,&var));
	%let dtype = %sysfunc(vartype(&dsid,&dnum));
	%let rc=%sysfunc(close(&dsid));
	&dtype;
%mend;

/*
%put %get_type(sashelp.class,weight);
*/
