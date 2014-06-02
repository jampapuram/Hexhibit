
  CREATE OR REPLACE  VIEW HV_SEBI_REGULATORY_NCA (SECURITY, ISIN_CODE, SECURITY_NAME, ASSET_NAME, SECTOR_CATEGORY, ISSUER, ISSUER_NAME, COUPON_RATE, PORTFOLIO, FACE_VALUE, TRANS_DATE, ASSET_CLASS, QTY_LOGICAL, ACQU_COST_TCY, NET_CURRENT_ASSETS, NET_ASSET_VALUE, MARKET_VALUE, MATURITY_DATE, PORTFOLIO_CATEGORY_NAME, FF_VC1, SEBI_SCHEME_CLASS, FRONTEND_RATING, MATURITY_DAYS, REGULATORY_STAMPING, SEBI_STAMPING, SEBI_SCHEME_CATEGORY, MCR_ASSET_TYPE, MCR_SUB_ASSET_TYPE, SECTOR_ALT, INDUSTRY_NAME, QUANTIS_DATE) AS 
  select  
A.SECURITY,
  A.ISIN_CODE,
  A.SECURITY_NAME,
  A.ASSET_NAME,
  A.SECTOR_CATEGORY,
  A.ISSUER,
  A.ISSUER_NAME,
  A.COUPON_RATE,
  A.PORTFOLIO,
  A.FACE_VALUE,
  A.TRANS_DATE,
  A.ASSET_CLASS,
  A.QTY_LOGICAL,
  A.ACQU_COST_TCY,
  A.NET_CURRENT_ASSETS,
  A.NET_ASSET_VALUE,
  A.MARKET_VALUE_TCY MARKET_VALUE,
  A.MATURITY_DATE,
  A.PORTFOLIO_CATEGORY_NAME,
  A.FF_VC1 ,
  A.FF_VC2 SEBI_SCHEME_CLASS,
  A.FF_VC3 Frontend_rating,
  nvl((A.MATURITY_DATE-B.MONTH_END_DATE),0) MATURITY_DAYS,
  nvl(CASE 
 -- WHEN (A.MATURITY_DATE-B.MONTH_END_DATE)<90 THEN '< 90 DAYS'
  WHEN (decode(A.MATURITY_DATE,null,B.MONTH_END_DATE-B.MONTH_END_DATE,A.MATURITY_DATE-B.MONTH_END_DATE))<90   and a.asset_class<>'01' THEN '< 90 DAYS'
  WHEN ((A.MATURITY_DATE-B.MONTH_END_DATE) >90 AND (A.MATURITY_DATE-B.QUARTER_END_DATE) < 182)   THEN ' 90 DAYS TO < 182 DAYS'
  WHEN ((A.MATURITY_DATE-B.MONTH_END_DATE)> 182 AND (A.MATURITY_DATE-B.QUARTER_END_DATE) < 365)  THEN ' 182 DAYS < 1 YEAR'
  WHEN (A.MATURITY_DATE-B.MONTH_END_DATE) > 365  THEN '1 YEAR AND ABOVE'
  when a.asset_class='01' then'Equity'
  END,'NA') REGULATORY_STAMPING,
 nvl( CASE 
  --WHEN (A.MATURITY_DATE-B.MONTH_END_DATE)<30 THEN 'Less Than 30 Days'
  --WHEN (decode(A.MATURITY_DATE,null,B.MONTH_END_DATE-B.MONTH_END_DATE,A.MATURITY_DATE-B.MONTH_END_DATE))<=30   and C.MCR_ASSET_TYPE<>'Equity'  THEN 'Less Than 30 Days'
  WHEN (decode(A.MATURITY_DATE,null,B.MONTH_END_DATE-B.MONTH_END_DATE,A.MATURITY_DATE-B.MONTH_END_DATE))<=30   and a.asset_class<>'01'  THEN 'Less Than 30 Days'
  WHEN ((A.MATURITY_DATE-B.MONTH_END_DATE) >30 AND (A.MATURITY_DATE-B.MONTH_END_DATE) < =180)  THEN 'More than 30 days but less than 180 days'
  WHEN ((A.MATURITY_DATE-B.MONTH_END_DATE)> 180 AND (A.MATURITY_DATE-B.MONTH_END_DATE) < 365) THEN ' More than 180 days but less than 365 days'
  WHEN ((A.MATURITY_DATE-B.MONTH_END_DATE) > 365 AND (A.MATURITY_DATE-B.MONTH_END_DATE) < 1095) THEN 'More than 365 days but less than 3 years'
  WHEN ((A.MATURITY_DATE-B.MONTH_END_DATE) > 1095 AND (A.MATURITY_DATE-B.MONTH_END_DATE) < 2555) THEN 'More than 3 years but less than 7 years'
  WHEN (A.MATURITY_DATE-B.MONTH_END_DATE) > 2555  THEN 'More than 7 years'
 --when a.maturity_date is null and C.MCR_ASSET_TYPE='Equity' then'Equity'
 when a.asset_class='01' then'Equity'
  END,'na') SEBI_STAMPING,
nvl(CASE
  WHEN A.FF_VC2='Debt (other than assured return schemes)' OR A.FF_VC2='Gilt' OR A.FF_VC2='Liquid / Money Market'  THEN '(A) INCOME/DEBT ORIENTED SCHEMES'
  WHEN A.FF_VC2='Other schemes' OR A.FF_VC2='ELSS schemes' THEN '(B) GROWTH/EQUITY ORIENTED SCHEMES'
  WHEN A.FF_VC2='Balanced schemes' THEN '(C)BALANCED SCHEME'
  WHEN A.FF_VC2='ETF' THEN 'ETF'
  WHEN A.FF_VC2='FUND OF FUND SCHEMES' THEN 'FOF'
  --when a.ff_vc2='Debt (other than assured return schemes)' or a.ff_vc2='Balanced schemes' or a.ff_vc2='ELSS schemes' or A.FF_VC2='Other schemes' and C.MCR_ASSET_TYPE='Equity' then ''
  END,'na') SEBI_SCHEME_CATEGORY,
  C.MCR_ASSET_TYPE,
  C.MCR_SUB_ASSET_TYPE,
  C.SECTOR_ALT,
  A.INDUSTRY_NAME,
  nvl(A.ff_d1,'01-01-2000') quantis_date
  FROM HREP_SECURITY_HOLDING_CURR A,
  HDIM_TIME_CAL B,HREP_SECURITY_DETAIL_CURR C
WHERE --A.TRANS_DATE                  ='31 DEC 2013' and--Comment by gaurav for validating the records 
PORTFOLIO NOT IN ('HUNCRED1','HUNCRED2','PRUOLD')
and a.MODULE_REF ='HOLDING'
AND A.trans_date=B.DAY_END_DATE
AND A.SECURITY=C.SECURITY(+)
UNION ALL
SELECT
 'NCA' SECURITY,
NULL ISIN_CODE,
 'NET CURRENT ASSETS' SECURITY_NAME,
  'NET CURRENT ASSETS' ASSET_NAME,
  null SECTOR_CATEGORY,
  'NCA' ISSUER,
  'NET CURRENT ASSETS' ISSUER_NAME,
  0 COUPON_RATE,
  accbal.scheme Portfolio,
  0 FACE_VALUE,
accbal.nav_date Trans_Date,
'NCA' ASSET_CLASS,
  NULL QTY_LOGICAL,
 NULL ACQU_COST_TCY,
 SUM(CASE WHEN /*accbal.control_ac*/SUBSTR(accbal.account, 1, 6) NOT IN ('110100', '111800', '010103', '080100') THEN (accbal.amount *-1) ELSE 0 END)    AS net_current_assets,
 NAV NET_ASSET_VALUE,
 SUM(accbal.amount*-1) AS market_value,
 null MATURITY_DATE,
 SALT.SCHEMETYPETWO PORTFOLIO_CATEGORY_NAME,
 SALT.SCHEMETYPE ff_vc1,
 SALT.SEBISCHEMECLASS,
 null Frontend_rating,
 0 MATURITY_DAYS,
 '< 90 DAYS' REGULATORY_STAMPING,
 'Less Than 30 Days' SEBI_STAMPING,
  CASE
  WHEN SALT.SEBISCHEMECLASS='Debt (other than assured return schemes)' OR SALT.SEBISCHEMECLASS='Gilt' OR SALT.SEBISCHEMECLASS='Liquid / Money Market'  THEN '(A) INCOME/DEBT ORIENTED SCHEMES'
  WHEN SALT.SEBISCHEMECLASS='Other schemes' OR SALT.SEBISCHEMECLASS='ELSS schemes' THEN '(B) GROWTH/EQUITY ORIENTED SCHEMES'
  WHEN SALT.SEBISCHEMECLASS='Balanced schemes' THEN '(C)BALANCED SCHEME'
  WHEN SALT.SEBISCHEMECLASS='ETF' THEN 'ETF'
  WHEN SALT.SEBISCHEMECLASS='FUND OF FUND SCHEMES' THEN 'FOF'
  END SEBI_SCHEME_CATEGORY,
  'NET CURRENT ASSETS' MCR_ASSET_TYPE,
  NULL MCR_SUB_ASSET_TYPE,
'OTHERS' SECTOR_ALT,
  'NCA' INDUSTRY_NAME,
  to_date('01-01-2000') quantis_date
 --SUM(CASE WHEN /*accbal.control_ac*/ SUBSTR(accbal.account, 1, 6) IN ('010103', '080100') or substr(accbal.ACCOUNT, 1, 6)= 'INV26'THEN (accbal.amount*-1) ELSE 0 END) AS liquidity ///comment by gaurav liquidity calclation not used 
 FROM hm_scheme scheme,
      hi_lastnav_curr ACCBAL,hm_scheme_alt salt--,hrep_security_detail_curr security
    WHERE scheme.amc_code      = accbal.amc_code
    AND scheme.scheme          = accbal.scheme
    AND accbal.nav_method      = 'A'
    AND accbal.security       IS NULL
    and accbal.scheme=SALT.SCHEMECODE
      AND accbal.control_ac NOT IN (scheme.unit_capac, scheme.unit_reserve, scheme.prft_loss_acct, scheme.distributable_inc_acct)
    --a--nd accbal.scheme='HDFLSP'
   --a--nd nav_date='31 dec 2013'--comment block by gaurav to be used for validation purpose 
   --AND ASSET_TYPE='01'
    --AND accbal.         = security.portfolio*/
    GROUP BY salt.ff_vc1,accbal.scheme,scheme.scheme_name,SALT.SCHEMECODE,SALT.SCHEMECATEGORY,SALT.SCHEMETYPE,SALT.SCHEMETYPETWO,SALT.SEBISCHEMECLASS,accbal.nav_date,NAV;
 
