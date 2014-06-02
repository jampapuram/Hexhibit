
  CREATE OR REPLACE  VIEW HV_OUTSTANDING_DERIVATE (SECURITY, PORTFOLIO, PRICE, MKT_PRICE, PORTFOLIO_NAME, SECURITY_NAME, TRANS_DATE, MATURITY_DATE, TRANS_CODE, QUANTITY, VALUE_DATE) AS 
  SELECT DISTINCT(HDT.SECURITY) as security,
  hdt.portfolio,
  HDT.PRICE,
  MKT.MKT_PRICE,
  hdt.portfolio_name,
  --hdt.security,
  hdt.security_name,
  hdt.trans_date,
  hdt.maturity_date,
  hdt.trans_code,
  -hdt.quantity as quantity,
  mkt.value_date 
  --  hdt.trans_date-1 prev_day
FROM HREP_DERIVATIVES_TXN_CURR hdt,
  HI_MKTPRICE_CURR mkt
where hdt.security                   =mkt.security
--and mkt.value_date                   ='30 Sep 2013'
AND hdt.trans_date                  <= MKT.VALUE_DATE
AND hdt.maturity_date                >hdt.trans_date
AND hdt.maturity_date-hdt.trans_date >0
ORDER BY 1;
 
