--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure HP_EQUITY_CHECK
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE HP_EQUITY_CHECK 
AS
BEGIN
  INSERT
  INTO HI_EQUITY_CHECK
    (
      EQUITY_ID,
      SOURCE,
NAV_DATE,
SECURITY,
STK_SEC_ID,
AMT,
TICKER,
S_STK_ID,
NSE_CODE,
NSE_CLOSE,
BSE_CODE,
BSE_CLOSE
    )
  SELECT EQUITY_SEQ.NEXTVAL ,
   SOURCE,
NAV_DATE,
SECURITY,
STK_SEC_ID,
AMT,
TICKER,
S_STK_ID,
NSE_CODE,
NSE_CLOSE,
BSE_CODE,
BSE_CLOSE
  FROM HV_EQUITY_CHECK_EOD1;
END;

/
