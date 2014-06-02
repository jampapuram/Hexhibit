
  CREATE OR REPLACE  VIEW HV_AUM_INDEX_ANALYSIS (INDEX_DESCRIPTION, INDEX_RATE, INDEX_DATE, PREV_DATE, PREV_RATE) AS 
  SELECT index_description,
  index_rate,
  index_date,
  nvl(previous_date,'01 JAN 1900') as prev_date,
  NVL(previous_rate,0) as prev_rate
FROM
  (SELECT index_description,
    index_rate,
    index_date,
    lag(index_date,1)over (partition BY index_description order by index_description,index_date) previous_date,
    lag(index_rate,1)over (partition BY index_description order by index_description,index_date) previous_rate
  FROM HUPD_INDEX_UPLOAD
  );
 
