
  CREATE OR REPLACE  VIEW HV_EQUITY1_MARKETPRICE (SECURITY, ISSUER, VALUE_DATE, MKT_PRICE) AS 
  select a.security,a.issuer,b.value_date,b.mkt_price from hrep_security_holding_curr a ,hi_mktprice_curr b
 where a.security=b.security
 and A.MODULE_REF='FUTURE';
 
