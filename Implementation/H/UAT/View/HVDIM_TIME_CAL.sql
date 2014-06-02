
  CREATE OR REPLACE  VIEW HVDIM_TIME_CAL (ORG_ID, DAY_ID, DAY_TIME_SPAN, DAY_END_DATE, WEEK_DAY_FULL, WEEK_DAY_SHORT, DAY_NUM_OF_WEEK, WEEK_OF_YEAR, NO_WEEK_OF_MONTH, DAY_NUM_OF_MONTH, DAY_NUM_OF_YEAR, MONTH_ID, YEAR_MONTH_ID, MONTH_TIME_SPAN, MONTH_END_DATE, MONTH_SHORT_DESC, MONTH_LONG_DESC, MONTH_SHORT, MONTH_LONG, MONTH_NUM_OF_YEAR, QUARTER_ID, QUARTER, QUARTER_TIME_SPAN, QUARTER_END_DATE, QUARTER_NUM_OF_YEAR, FISC_IND_QUARTER, FISC_NUM_IND_QUARTER, FISC_IND_QUARTER_NUM, QUARTER_END_IND, HALF_NUM_OF_YEAR, HALF_OF_YEAR_ID, YEAR_ID, YEAR_TIME_SPAN, YEAR_END_DATE, WORK_DAY_IND, WEEK_END_IND, HOLIDAY_YN, MONTH_END_IND) AS 
  SELECT 'HDFC' as ORG_ID,
To_CHAR(CurrDate,'DD-MM-YYYY') AS Day_ID,
1 AS Day_Time_Span,
CurrDate AS Day_End_Date,
TO_CHAR(CurrDate,'Day') AS Week_Day_Full,
TO_CHAR(CurrDate,'DY') AS Week_Day_Short,
To_Number(Trim(Leading '0' From To_Char(Currdate,'D'))) As Day_Num_Of_Week,
'W-' ||Upper(To_Char(Currdate,'WW')) Week_Of_Year,
'W-' ||Upper(To_Char(CurrDate,'W')) No_WEEK_OF_Month,
TO_NUMBER(TRIM(leading '0' FROM TO_CHAR(CurrDate,'DD'))) AS Day_Num_of_Month,
TO_NUMBER(TRIM(leading '0' FROM TO_CHAR(CurrDate,'DDD'))) AS Day_Num_of_Year,
UPPER(TO_CHAR(CurrDate,'Mon') || '-' || TO_CHAR(CurrDate,'YYYY')) AS Month_ID,
TO_NUMBER(TO_CHAR(CurrDate,'YYYYMM')) AS Year_Month_ID, ---SORTING AS NUMBER
-- 31 AS Month_Time_Span,
MAX(TO_NUMBER(TO_CHAR(CurrDate, 'DD'))) OVER (PARTITION BY TO_CHAR(CurrDate,'Mon')) AS Month_Time_Span,
--to_date('31-JAN-2010','DD-MON-YYYY') AS Month_End_Date,
MAX(CurrDate) OVER (PARTITION BY TO_CHAR(CurrDate,'YYYYMM')) as Month_End_Date,
--MAX(CurrDate) OVER (PARTITION BY TO_CHAR(CurrDate,'Mon')) as Month_End_Date,
TO_CHAR(CurrDate,'Mon') || ' ' || TO_CHAR(CurrDate,'YYYY') AS Month_Short_Desc,
RTRIM(TO_CHAR(CurrDate,'Month')) || ' ' || TO_CHAR(CurrDate,'YYYY') AS Month_Long_Desc,
TO_CHAR(CurrDate,'Mon') AS Month_Short,
TO_CHAR(CurrDate,'Month') AS Month_Long,
TO_NUMBER(TRIM(leading '0'FROM TO_CHAR(CurrDate,'MM'))) AS Month_Num_of_Year,
'Q' || Upper(To_Char(Currdate,'Q') || '-' || To_Char(Currdate,'YYYY')) As Quarter_Id,
'Q' || UPPER(TO_CHAR(CurrDate,'Q')) AS Quarter,
-- 31 AS Quarter_Time_Span,
COUNT(*) OVER (PARTITION BY TO_CHAR(CurrDate,'Q')) AS Quarter_Time_Span,
-- to_date('31-JAN-2010','DD-MON-YYYY') AS Quarter_End_Date,
MAX(CurrDate) OVER (PARTITION BY TO_CHAR(CurrDate,'Q')||'-' || To_Char(Currdate,'YYYY')) AS Quarter_End_Date,
TO_NUMBER(TO_CHAR(CurrDate,'Q')) AS Quarter_Num_of_Year,
-----------TO CONFIGURE INDIAN FISCAL CALENDAR
CASE
         WHEN To_Number(TO_CHAR(CurrDate, 'Mm')) BETWEEN 1 AND 3 THEN 'Fourth Quarter'
         WHEN To_Number(TO_CHAR(CurrDate, 'Mm')) BETWEEN 4 AND 6 THEN 'First Quarter'
         WHEN To_Number(TO_CHAR(CurrDate, 'Mm')) BETWEEN 7 AND 9 THEN 'Second Quarter'
         WHEN To_Number(TO_CHAR(CurrDate, 'Mm')) BETWEEN 10 AND 12 THEN 'Third Quarter'
     END AS fisc_ind_quarter,
     CASE
         WHEN To_Number(TO_CHAR(CurrDate, 'Mm'))BETWEEN 1 AND 3 THEN 'FQ-4' 
         WHEN To_Number(TO_CHAR(CurrDate, 'Mm')) BETWEEN 4 AND 6 THEN 'FQ-1'
         WHEN To_Number(TO_CHAR(CurrDate, 'Mm')) BETWEEN 7 AND 9 THEN 'FQ-2' 
         WHEN To_Number(TO_CHAR(CurrDate, 'Mm')) BETWEEN 10 AND 12 THEN 'FQ-3'
     END AS fisc_Num_ind_quarter,
     CASE
         WHEN To_Number(TO_CHAR(CurrDate, 'Mm')) BETWEEN 1 AND 3 THEN 4
         WHEN To_Number(TO_CHAR(CurrDate, 'Mm')) BETWEEN 4 AND 6 THEN 1
         WHEN To_Number(TO_CHAR(CurrDate, 'Mm')) BETWEEN 7 AND 9 THEN 2
         WHEN To_Number(TO_CHAR(CurrDate, 'Mm')) BETWEEN 10 AND 12 THEN 3
     END AS fisc_ind_quarter_NUM,
      CASE
WHEN TO_CHAR(CurrDate,'Q')= TO_CHAR(CurrDate + 1, 'Q') THEN
'N'
ELSE
'Y'
END AS QUARTER_END_IND,
 CASE
      WHEN TO_NUMBER(TO_CHAR(CurrDate,'Q')) <= 2
      THEN 1
      ELSE 2
    END AS half_num_of_year,
    CASE
      WHEN TO_NUMBER(TO_CHAR(CurrDate,'Q')) <= 2
      THEN 'H'
        || 1
        || '-'
        || TO_CHAR(CurrDate,'YYYY')
      ELSE 'H'
        || 2
        || '-'
        || TO_CHAR(CurrDate,'YYYY')
    END                      AS half_of_year_id,
TO_CHAR(CurrDate,'YYYY') AS Year_ID,
--31 AS Year_Time_Span,
COUNT(*) OVER (PARTITION BY TO_CHAR(CurrDate,'YYYY')) AS Year_Time_Span,
-- to_date('31-JAN-2010','DD-MON-YYYY') AS Year_End_Date
Max(Currdate) Over (Partition By To_Char(Currdate,'YYYY')) Year_End_Date,
DECODE(TO_CHAR(CurrDate, 'D'), '7', 'N', '1', 'N', 'Y') AS WORK_DAY_IND,
DECODE(TO_CHAR(CurrDate, 'D'), '7', 'Y', '1', 'Y', 'N') AS WEEK_END_IND,
'N' AS HOLIDAY_YN,
Case
when MAX(CurrDate) OVER (PARTITION BY TO_CHAR(CurrDate,'YYYYMM')) =  (CurrDate) then
'Y'
ELSE 
'N' 
end AS Month_End_Ind
FROM
(SELECT level n,
------------------------------------------------------------------------------------- Calendar starts at the day after this date.PLEASE CHANGE THE DATE HERE for DCB
TO_DATE('31/03/2007','DD/MM/YYYY') + NUMTODSINTERVAL(level,'day') CurrDate
FROM dual   
-- Change for the number of days to be added to the table.
Connect By Level <=4749) ORDER BY CURRDATE;
 
