
  CREATE OR REPLACE  VIEW HV_DT_TIME_SEBI_REGULATORY (SEC_HOLD_ID, TRANS_DATE, DAY_ID, WEEK_OF_YEAR, MONTH_ID, YEAR_MONTH_ID, FISC_NUM_IND_QUARTER, MONTH_END_DATE, QUARTER_END_DATE, YEAR_ID) AS 
  SELECT  HREP_SECURITY_HOLDING_CURR.SEC_HOLD_ID,
HREP_SECURITY_HOLDING_CURR.TRANS_DATE,
to_date(HDIM_TIME_CAL.DAY_ID,'DD-MM-YYYY') DAY_ID,
HDIM_TIME_CAL.WEEK_OF_YEAR,
HDIM_TIME_CAL.MONTH_ID,
YEAR_MONTH_ID,
HDIM_TIME_CAL.FISC_NUM_IND_QUARTER,
HDIM_TIME_CAL.MONTH_END_DATE,
HDIM_TIME_CAL.QUARTER_END_DATE,
HDIM_TIME_CAL.YEAR_ID
FROM HREP_SECURITY_HOLDING_CURR, HDIM_TIME_CAL WHERE  HREP_SECURITY_HOLDING_CURR.TRANS_DATE = HDIM_TIME_CAL.DAY_END_DATE;
 
