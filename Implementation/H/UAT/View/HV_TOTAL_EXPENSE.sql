
  CREATE OR REPLACE  VIEW HV_TOTAL_EXPENSE (SCHEME, EXPENSE, EXPENSE_RATE, TER, LOAD, TOTAL_MGMT_FEES_AMOUNT, TOTAL_EXPENSE, DP) AS 
  SELECT DISTINCT EXP.SCHEME,
  DECODE(EXP.AUM_CR,0,0,((EXP.A1+EXP.A2+EXP.A3+EXP.A4)/EXP.AUM_CR*36500)) EXPENSE,
  EXP.EXPENSE_RATE,
  EXP.TER,
  EXP.LOAD,
  HI_MGMT_FEES_LIVE.TOTAL_MGMT_FEES_AMOUNT,
  ROUND((NVL(EXP.EXPENSE_RATE,DECODE(EXP.AUM_CR,0,0,((EXP.A1+EXP.A2+EXP.A3+EXP.A4)/EXP.AUM_CR*36500)))+EXP.TER+EXP.LOAD + NVL(HI_MGMT_FEES_LIVE.TOTAL_MGMT_FEES_AMOUNT,0)),8) TOTAL_EXPENSE,
  HI_MGMT_FEES_LIVE.DP_UPLOAD DP
FROM
  (SELECT A.SCHEME SCHEME,
    A.AUM_CR,
    A.TER,
    A.LOAD,
    A.EXPENSE_RATE,
    CASE
      WHEN A.AUM_CR < 100
      THEN ((A.AUM_CR)*0.0225/365)
      ELSE 0.006164384
    END AS A1,
    CASE
      WHEN (A.AUM_CR) > 100
      THEN
        CASE
          WHEN ((A.AUM_CR)-100) < 300
          THEN ((A.AUM_CR)*0.02/365)
          ELSE 0.016438356
        END
      ELSE 0
    END AS A2,
    CASE
      WHEN (A.AUM_CR) > 400
      THEN
        CASE
          WHEN (A.AUM_CR-400) < 300
          THEN (A.AUM_CR*0.0175/365)
          ELSE 0.014383562
        END
      ELSE 0
    END AS A3,
    CASE
      WHEN A.AUM_CR > 700
      THEN ((A.AUM_CR-700)*0.015/365)
      ELSE 0
    END AS A4
    --IF(A.LAST_NET_ASSETS>100,MIN(300,A.LAST_NET_ASSETS-100))*0.02/365 A2,
    --IF(A.LAST_NET_ASSETS>400,MIN(300,A.LAST_NET_ASSETS-400))*0.0175/365 A3,
    --IF(A.LAST_NET_ASSETS>700,(A.LAST_NET_ASSETS-700))*0.015/365)/A.LAST_NET_ASSETS*36500) A4
  FROM
    (SELECT B.scheme,
      --sum(B.TER) TER,--COMMENT BY GAURAV TO SUPRESS SUMMING UP OF THE EXPENSE RATE,TER,LOAD AND AUM
      --sum(B.LOAD) LOAD,
      AVG(B.TER) TER,
      AVG(B.LOAD) LOAD,
      --SUM(NVL(B.EXPENSE_RATE,0))EXPENSE_RATE, comment by gaurav 
      --AVG(NVL(B.EXPENSE_RATE,0))EXPENSE_RATE,
      decode(avg(B.EXPENSE_RATE),0,0,avg(B.EXPENSE_RATE))EXPENSE_RATE,
      AVG(B.LNA/10000000) AUM_CR
    FROM HV_AUM_UNITS_NAV B
    GROUP BY B.SCHEME--,B.EXPENSE_RATE
    ) A
  ) EXP,
  HI_MGMT_FEES_LIVE HI_MGMT_FEES_LIVE
WHERE EXP.SCHEME = HI_MGMT_FEES_LIVE.SCHEME(+);
 
