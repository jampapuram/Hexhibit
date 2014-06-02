
  CREATE OR REPLACE  VIEW HV_REPSAL (SCHEME, NET_FLOW, INFLOW, OUTFLOW, CONTROL, DIVIDEND, MON, MON_NUM, YY_NUM, VALUE_DATE) AS 
  SELECT scheme,
  SUM(neg_net_flow       + pos_net_flow)                                                                                                  AS net_flow,
  ROUND(SUM(neg_inflow   +pos_inflow)/10000000,2)                                                                                         AS inflow,
  ROUND(SUM(NEG_OUTFLOW  +POS_OUTFLOW)/10000000,2)                                                                                        AS OUTFLOW,
  (SUM(neg_net_flow      + pos_net_flow) ) - ((SUM(neg_inflow +pos_inflow)/10000000)- (SUM(neg_outflow +pos_outflow)/10000000))* 10000000 AS control,
  ROUND(SUM(neg_dividend +pos_dividend)/10000000,2)                                                                                       AS dividend ,
  MON,
  MON_NUM,
  YY_NUM,
  VALUE_DATE
FROM
  (SELECT scheme,
  tran_type,
  SUM(amt) AS amount,
  CASE
    WHEN TRAN_TYPE = 'DIVRNC'
    OR TRAN_TYPE   ='DIVRNE'
    OR TRAN_TYPE   = 'REVSAL'
    OR TRAN_TYPE   = 'REVSWN'
    OR TRAN_TYPE   = 'SWOUT'
    OR TRAN_TYPE   ='UNPUR'
    THEN -(SUM(amt))
    ELSE 0
  END AS NEG_NET_FLOW,
  CASE
    WHEN TRAN_TYPE = 'RDIV'
    OR TRAN_TYPE   ='RDIVE'
    OR TRAN_TYPE   ='REVPUR'
    OR TRAN_TYPE   = 'REVSWO'
    OR TRAN_TYPE   = 'SWIN'
    OR TRAN_TYPE   ='UNSAL'
    THEN SUM(amt)
    ELSE 0
  END AS POS_NET_FLOW,
  CASE
    WHEN TRAN_TYPE = 'DIVRNC'
    OR TRAN_TYPE   ='DIVRNE'
    OR TRAN_TYPE   = 'REVSAL'
    OR TRAN_TYPE   = 'REVSWN'
    THEN -(SUM(amt))
    ELSE 0
  END AS NEG_INFLOW,
  CASE
    WHEN TRAN_TYPE = 'RDIV'
    OR TRAN_TYPE   ='RDIVE'
    OR TRAN_TYPE   = 'SWIN'
    OR TRAN_TYPE   ='UNSAL'
    THEN SUM(amt)
    ELSE 0
  END AS POS_INFLOW,
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
  END AS POS_OUTFLOW,
  CASE
    WHEN TRAN_TYPE = 'DIVRNC'
    OR TRAN_TYPE   ='DIVRNE'
    THEN -(SUM(amt))
    ELSE 0
  END AS NEG_DIVIDEND,
  CASE
    WHEN TRAN_TYPE = 'RDIV'
    OR TRAN_TYPE   ='RDIVE'
    THEN SUM(amt)
    ELSE 0
  END AS pos_dividend ,
  MON,
  MON_NUM,
  YY_NUM,
  VALUE_DATE
FROM
  (SELECT repsal. scheme,
    repsal. tran_type,
    SUM(repsal.amount - repsal.loadamount ) AS amt,
    TO_CHAR(repsal. value_date,'MONTH')     AS MON,
    TO_NUMBER(TO_CHAR(repsal. value_date,'MM')) MON_NUM,
    TO_NUMBER(TO_CHAR(repsal. value_date,'YYYY')) YY_NUM, 
    REPSAL.VALUE_DATE
  FROM hi_repsal_curr repsal
  WHERE (repsal.rectype='L')
  --AND (repsal.value_date BETWEEN '01 Jan 2014' AND '08 Jan 2014') -- need to remove this filter
    --AND (repsal.tran_type IN ('UNPUR','SWOUT','REVSWO','REVPUR'))
  --AND scheme ='HDFCGR'
  GROUP BY repsal.scheme ,
    repsal.tran_type ,REPSAL.VALUE_DATE,
    TO_CHAR(repsal. value_date,'MONTH'),
    TO_NUMBER(TO_CHAR(repsal. value_date,'MM')),
    TO_NUMBER(TO_CHAR(repsal. value_date,'YYYY'))
  ORDER BY TO_NUMBER(TO_CHAR(repsal. value_date,'YYYY')),
    TO_NUMBER(TO_CHAR(repsal. value_date,'MM'))
  )
GROUP BY scheme,
  tran_type,
  MON,
  MON_NUM,
  YY_NUM,VALUE_DATE)
GROUP BY scheme,
  MON,
  MON_NUM,
  YY_NUM,VALUE_DATE
ORDER BY YY_NUM,
  MON_NUM;
 
