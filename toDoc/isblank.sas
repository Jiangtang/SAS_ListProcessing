/*
https://www.marc.info/?l=sas-l&m=142177161422037&w=2

http://support.sas.com/resources/papers/proceedings09/022-2009.pdf
by Chang Y. Chung, John King
*/

%macro isblank(param);
 %sysevalf(%superq(param)=,boolean)
%mend isblank; 