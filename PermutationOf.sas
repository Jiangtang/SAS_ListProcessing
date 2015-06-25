/*
by Jian Dai
https://www.clinovo.com/userfiles/PharmaSug-SAS-Macros-for-List-Permutations.pdf

*/

%macro TheFirstWordOf(List=);
	%scan(&List,1)
%mend;

%macro ExceptTheFirstWord_SubListOf(List=);
	%local L; %let L=%length(%TheFirstWordOf(List=&List));
	%if &L<%length(&List) %then %left(%substr(&List,%eval(1+&L)));
%mend;

%macro ForEach(ItemRef,In=,Do=%nrstr(/* Nothing */));
	%if %left(%trim(&In))^= %then %do;
		%let &ItemRef=%TheFirstWordOf(List=&In);
		%unquote(&Do);
		%ForEach(&ItemRef,In=%ExceptTheFirstWord_SubListOf(List=&In),Do=&Do)
	%end;
%mend;

%macro ComplementOfWord(w,In=);
	%local _1stWord;
	%if &In^= %then %do;
		%let _1stWord=%TheFirstWordOf(List=&In);
		%if &_1stWord=&w %then
		%ComplementOfWord(&w,
		In=%ExceptTheFirstWord_SubListOf(List=&In));
		%else &_1stWord %ComplementOfWord(&w,
		In=%ExceptTheFirstWord_SubListOf(List=&In));
	%end;
%mend;

%macro PermutationOf(
List,
SelectedPath=,
Execute=%nrstr(%put &SelectedPath;)
);
	%If &List= %Then
	%unquote(&Execute) ;
	%Else %do;
		%ForEach(word, In=&List,
		Do=%nrstr(
		%PermutationOf(
		%ComplementOfWord(&word,In=&List),
		SelectedPath=&SelectedPath &word,
		Execute=&Execute
		)
		)
		)
	%end;
%mend;
%PermutationOf(1 2 3 )



%let c=0;
%PermutationOf(1 2 3 4,Execute=%nrstr(%let c=%eval(&c+1);%put &c: &SelectedPath;))


data Perm5;
	%PermutationOf(1 2 3 ,Execute=%nrstr(
	perm="&SelectedPath &word";output;))
run;
