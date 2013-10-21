--------------------------------------------------------
--  File created - Friday-October-18-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View HV_MONTH_ON_BOOKS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "RIGEL"."HV_MONTH_ON_BOOKS" ("MONTH_YEAR", "COUNT_MONTH", "PREV_MONTH", "MONTH_ON_MONTH", "MONTH_ON_BOOKS") AS 
  SELECT TO_DATE (TO_CHAR(NVL(application_dt,'01-JAN-2099'),'YYYY-MON'),'YYYY-MON') AS MONTH_YEAR , COUNT(DISTINCT application_no) AS COUNT_MONTH,
LAG(COUNT(DISTINCT application_no), 1, 0) OVER (ORDER BY TO_DATE (TO_CHAR(NVL(application_dt,'01-JAN-2099'),'YYYY-MON'),'YYYY-MON')) AS  PREV_MONTH,
COUNT(DISTINCT application_no) - LAG(COUNT(DISTINCT application_no), 1, 0) OVER (ORDER BY TO_DATE (TO_CHAR(NVL(application_dt,'01-JAN-2099'),'YYYY-MON'),'YYYY-MON')) AS  MONTH_ON_MONTH,
SUM(COUNT(DISTINCT application_no)) OVER (ORDER BY TO_DATE (TO_CHAR(NVL(application_dt,'01-JAN-2099'),'YYYY-MON'),'YYYY-MON')) AS  MONTH_ON_BOOKS
FROM HI_APPLICATION_DEMOGRAPHICS
--WHERE application_dt IS NOT NULL
GROUP BY TO_DATE (TO_CHAR(NVL(application_dt,'01-JAN-2099'),'YYYY-MON'),'YYYY-MON') 
ORDER BY TO_DATE (TO_CHAR(NVL(application_dt,'01-JAN-2099'),'YYYY-MON'),'YYYY-MON') ASC;
