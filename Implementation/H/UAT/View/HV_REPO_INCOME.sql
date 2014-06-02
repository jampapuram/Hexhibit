
  CREATE OR REPLACE  VIEW HV_REPO_INCOME (SCHEME, TRAN_TYPE, NAME, VALUE_DATE, MAT_DATE, REPO_AMOUNT) AS 
  select repodeal.scheme,repodeal.tran_type,name,repodeal.value_date,
repodeal.mat_date,sum(repodeal.nett_val*repo_rate/100/365) REPO_AMOUNT
from (select scheme,deal_id,value_date,remarks,security,units,tran_type,asset_type,r.cparty_id,c.name,mat_date,nett_val,repo_rate
from HI_REPO_DEAL_CURR  R,HM_CPARTY C 
where R.CPARTY_ID=C.CPARTY_ID
AND R.rectype='L'
AND C.RECTYPE='L') repodeal,SYSPARAM
where repodeal.value_date  < = sysparam.cur_date -1
and repodeal.mat_date >  sysparam.cur_date -1
and sysparam.rectype='L'
group by  repodeal.scheme,repodeal.tran_type,name,repodeal.value_date,repodeal.mat_date;
 
