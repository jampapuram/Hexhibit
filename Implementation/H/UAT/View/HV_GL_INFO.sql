
  CREATE OR REPLACE  VIEW HV_GL_INFO (LVL, AMOUNT, SCHEME, LEVEL_1, VALUE_DATE, ACCOUNT_NAME, ACCOUNT_CODE) AS 
  SELECT DISTINCT (h.LEVEL_1) AS LVL,
    SUM(hac.amount)           AS amount,
    hac.scheme                AS scheme,
    hac.level_1               AS level_1,
    hac.value_date            as value_date,
    h.name                    as account_name, 
    H.FF_VC1 AS ACCOUNT_CODE
  FROM hi_accent_curr hac,
    hi_account_curr h
  WHERE hac.scheme = h.scheme
  AND hac.level_1 LIKE '8%'
  AND (h.rectype='L')
  AND h.level_1 LIKE '8%'
    --and h.scheme = 'HDFCAR'
    --AND HAC.VALUE_DATE between '01 APR 2013' AND '30 NOV 2013'
  GROUP BY hac.scheme,
    hac.level_1,
    hac.value_date,
    h.level_1,
    h.name, H.FF_VC1;
 
