
  CREATE OR REPLACE  VIEW HV_LOAD (SCHEME, NET_AMOUNT, MON, MON_NUM, YY_NUM, VALUE_DATE) AS 
  SELECT scheme,
  (SUM(POS_OUTFLOW + NEG_OUTFLOW)/10000000)*2 AS net_amount,
  MON,
  MON_NUM,
  YY_NUM, value_date
FROM
  (SELECT scheme,
    tran_type,
    CASE
      WHEN TRAN_TYPE = 'REVPUR'
      OR TRAN_TYPE   ='REVSWO'
      THEN -(SUM(amt))
      ELSE 0
    END AS NEG_OUTFLOW,
    CASE
      WHEN TRAN_TYPE = 'SWOUT'
      OR TRAN_TYPE   ='UNPUR'
      THEN SUM(amt)
      ELSE 0
    END AS pos_outflow,
    MON,
    MON_NUM,
    YY_NUM,
value_date
  FROM
    (SELECT repsal.scheme,
      repsal.tran_type,
      SUM(loadamount)                     AS amt,
      TO_CHAR(repsal. value_date,'MONTH') AS MON,
      TO_NUMBER(TO_CHAR(repsal. value_date,'MM')) MON_NUM,
      TO_NUMBER(TO_CHAR(repsal. value_date,'YYYY')) YY_NUM,
repsal.value_date
    FROM hi_repsal_curr repsal
    WHERE (repsal.rectype='L')
     -- AND (repsal.value_date BETWEEN '01 Jan 2014' AND '08 Jan 2014') -- need to remove this filter
    AND (repsal.tran_type IN ('UNPUR','SWOUT','REVSWO','REVPUR'))
     --  and scheme ='HDFCGR'
      -- and tran_type = 'SWOUT'
    GROUP BY repsal.SCHEME,
      repsal.TRAN_TYPE,
      TO_CHAR(repsal. value_date,'MONTH'),
      TO_NUMBER(TO_CHAR(repsal. value_date,'MM')),
      TO_NUMBER(TO_CHAR(repsal. value_date,'YYYY')),repsal.value_date
    ORDER BY TO_NUMBER(TO_CHAR(repsal. value_date,'YYYY')),
      TO_NUMBER(TO_CHAR(repsal. value_date,'MM'))
    )
  GROUP BY scheme,
    tran_type,
    MON,
    MON_NUM,
    YY_NUM,value_date
  )
GROUP BY scheme,
  MON,
  MON_NUM,
  YY_NUM,value_date
ORDER BY YY_NUM,
  MON_NUM;
 
