
  CREATE OR REPLACE  VIEW HV_INCOME_EXPENSE (SCHEME, PROFIT, LOSS, DIVIDEND, INTEREST, OPERATING_EXPENSE, DIVIDEND_EXPENSE, IIE, VALUE_DATE) AS 
  WITH TEMP_DATA AS
  (SELECT scheme,
    'Profit'                               AS des,
    NVL(ROUND((SUM(amount)/10000000),2),0) AS amt,
    value_date
  FROM hi_accent_curr
  WHERE /*value_date BETWEEN '1 Jan 2014' AND '08 Jan 2014'
    AND */  level_1 IN ('610520','611000','611010','611100','611200')
    -- AND scheme   = 'HDFCCS'
  GROUP BY scheme,
    level_1,
    value_date
  UNION ALL
  SELECT scheme,
    'LOSS'                                 AS des,
    NVL(ROUND((SUM(amount)/10000000),2),0) AS amt,
    value_date
  FROM hi_accent_curr
  WHERE /*value_date BETWEEN '1 Jan 2014' AND '08 Jan 2014'
    AND*/     level_1 IN ('810010','810011','810020')
    --AND scheme   = 'HDFCCS'
  GROUP BY scheme,
    level_1,
    value_date
  UNION ALL
  SELECT scheme,
    'DIVIDEND'                             AS des,
    NVL(ROUND((SUM(amount)/10000000),2),0) AS AMT,
    value_date
  FROM hi_accent_curr
  WHERE /*value_date BETWEEN '1 Jan 2014' AND '08 Jan 2014'
    AND */level_1 IN ('610102','610230')
    -- AND scheme   = 'HDFCCS'
  GROUP BY scheme,
    level_1,
    value_date
  UNION ALL
  SELECT scheme,
    'INTEREST'                             AS des,
    NVL(ROUND((SUM(amount)/10000000),2),0) AS amt,
    value_date
  FROM hi_accent_curr
  WHERE
    /*value_date BETWEEN '1 Jan 2014' AND '08 Jan 2014'
    AND*/ 
    level_1 IN ('610240','610401','610406','610408','611220','611500')
    --AND scheme   = 'HDFCCS'
  GROUP BY scheme,
    level_1,
    value_date
  UNION ALL
  SELECT scheme,
    'OPERATING EXPENSE'                    AS des,
    NVL(ROUND((SUM(amount)/10000000),2),0) AS amt,
    value_date
  FROM hi_accent_curr
  WHERE
    /*value_date BETWEEN '1 Jan 2014' AND '08 Jan 2014'
    AND */
    level_1 IN ('810000','810080','810100','810101','810115','810120','810140','810220','810230','810300','810311','810319','810321','810322','810339','810500','810850','811500','811700','811900','811901','815000','810150','810170','810190','810200','810210','810317')
    --AND scheme   = 'HDFCCS'
  GROUP BY scheme,
    level_1,
    value_date
  UNION ALL
  SELECT scheme,
    'DIVIDEND EXPENSE'                     AS des,
    NVL(ROUND((SUM(amount)/10000000),2),0) AS amt,
    value_date
  FROM hi_accent_curr
  WHERE
  /*  value_date BETWEEN '1 Jan 2014' AND '08 Jan 2014'
    AND*/
    level_1 IN ('310201','310202')
    --AND scheme   = 'HDFCCS'
  GROUP BY scheme,
    level_1,
    value_date
  UNION ALL
  SELECT scheme,
    'IIE'                                  AS des,
    NVL(ROUND((SUM(amount)/10000000),2),0) AS amt,
    value_date
  FROM hi_accent_curr
  where
   /* value_date BETWEEN '1 Jan 2014' AND '08 Jan 2014'
    AND */
    level_1 IN ('810600')
    --AND scheme   = 'HDFCCS'
  GROUP BY scheme,
    level_1,
    value_date
  )
SELECT SCHEME,
  PROFIT,
  LOSS,
  DIVIDEND,
  INTEREST,
  OPERATING_EXPENSE,
  DIVIDEND_EXPENSE,
  IIE,
  VALUE_DATE
FROM temp_data PIVOT( SUM(AMT) FOR DES IN ( 'Profit' AS PROFIT, 'LOSS' AS LOSS, 'DIVIDEND' AS DIVIDEND,'INTEREST' AS INTEREST, 'OPERATING EXPENSE'AS OPERATING_EXPENSE,'DIVIDEND EXPENSE' AS DIVIDEND_EXPENSE,'IIE' AS IIE));
 
