
  CREATE OR REPLACE  VIEW HV_MON_INC_EXP (SCHEME, NAV, CNT, MON, MON_NUM) AS 
  SELECT RT.SCHEME,
  RT. NAV,
  RT.CNT,
  RT. MON,
  RT.MON_NUM
FROM
  (SELECT SCHEME ,
    AVG(LAST_NET_ASSET) AS NAV,
    COUNT(SCHEME)       AS CNT,
    MON,
    mon_num
  FROM
    (SELECT weeknav.PORTFOLIO                      AS SCHEME,
      weeknav.TRANS_DATE                           AS WEEKEND_DT,
      TO_CHAR( weeknav.TRANS_DATE, 'MONTH')        AS MON,
      SUM(weeknav.NET_ASSETS_INC_EXP )             AS LAST_NET_ASSET,
      TO_NUMBER(TO_CHAR( weeknav.TRANS_DATE, 'MM'))AS mon_num
    FROM HREP_NAV_SUMMARY_CURR weeknav
    WHERE (weeknav.UNITS_OUTS<>'0')
   -- AND (weeknav.TRANS_DATE BETWEEN '01 APR 2013' AND '30 NOV 2013')
    AND (WEEKNAV.NAV_TYPE <>'FUND')
    GROUP BY weeknav.PORTFOLIO,
      weeknav.TRANS_DATE,
      TO_CHAR( weeknav.TRANS_DATE, 'MONTH'),
      TO_NUMBER(TO_CHAR( weeknav.TRANS_DATE, 'MM'))
    ORDER BY 1,
      2
    )
 -- WHERE SCHEME = 'HRGESS0113'
  GROUP BY SCHEME,
    MON,
    mon_num
  ) RT,
  (SELECT MAX(mon_num) AS MAX_MON_NUM,
    SCHEME
  FROM
    (SELECT weeknav.PORTFOLIO                      AS SCHEME,
      TO_NUMBER(TO_CHAR( weeknav.TRANS_DATE, 'MM'))AS mon_num
    FROM HREP_NAV_SUMMARY_CURR weeknav
    WHERE (weeknav.UNITS_OUTS<>'0')
  --  AND (weeknav.TRANS_DATE BETWEEN '01 APR 2013' AND '30 NOV 2013')
    AND (WEEKNAV.NAV_TYPE <>'FUND')
    GROUP BY weeknav.PORTFOLIO,
      TO_NUMBER(TO_CHAR( weeknav.TRANS_DATE, 'MM'))
    ORDER BY 1,
      2
    )
 -- WHERE SCHEME = 'HRGESS0113'
  GROUP BY SCHEME
  )MAX_RESULT
WHERE MAX_RESULT.SCHEME    = RT.SCHEME
AND MAX_RESULT.MAX_MON_NUM = RT.MON_NUM;
 
