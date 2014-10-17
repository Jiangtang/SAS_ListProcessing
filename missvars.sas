
%macro missvars(ds);

%local nvarsn nvarsc;
%global _miss_ _nonmiss_;
%let _miss_=;
%let _nonmiss_=;

%let nvarsn=%nvarsn(&ds);
%let nvarsc=%nvarsc(&ds);

data _null_;
  %if &nvarsn GT 0 %then %do;
    array _nmiss {&nvarsn} $ 1 _temporary_ (&nvarsn*'1');
  %end;
  %if &nvarsc GT 0 %then %do;
    array _cmiss {&nvarsc} $ 1 _temporary_ (&nvarsc*'1');
  %end;
  set &ds end=last;
  %if &nvarsn GT 0 %then %do;
    array _num {*} _numeric_;
  %end;
  %if &nvarsc GT 0 %then %do;
    array _char (*) _character_;
  %end;
  length _miss_ _nmiss_ $ 32767;
  retain _miss_ _nmiss_ " ";
  %if &nvarsn GT 0 %then %do;
    do i=1 to &nvarsn;
      if _num(i) NE . then _nmiss(i)='0';
    end;
  %end;
  %if &nvarsc GT 0 %then %do;
    do i=1 to &nvarsc;
      if _char(i) NE ' ' then _cmiss(i)='0';
    end;
  %end;
  if last then do;
    %if &nvarsn GT 0 %then %do;
      do i=1 to &nvarsn;
        if _nmiss(i) EQ '1' then _miss_=trim(_miss_)||" "||vname(_num(i));
        else _nmiss_=trim(_nmiss_)||" "||vname(_num(i));
      end;
    %end;
    %if &nvarsc GT 0 %then %do;
      do i=1 to &nvarsc;
        if _cmiss(i) EQ '1' then _miss_=trim(_miss_)||" "||vname(_char(i));
        else _nmiss_=trim(_nmiss_)||" "||vname(_char(i));
      end;
    %end;
    call symput('_miss_',left(trim(_miss_)));
    call symput('_nonmiss_',left(trim(_nmiss_)));
  end;
run;

%mend;
