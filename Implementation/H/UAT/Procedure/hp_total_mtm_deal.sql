--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure HP_TOTAL_MTM_DEAL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE HP_TOTAL_MTM_DEAL 
AS
BEGIN
  INSERT
  INTO HI_TOTAL_MTM_DEAL
    (
      TOTAL_MTM_DEAL_ID ,
      NSE_CODE ,
      SCHEME ,
      INDXFUTURE ,
      UNITS ,
      AVG_PRICE ,
      MARKET_VALUE ,
      LIABILITY_COST ,
      MTM_PRICE ,
      EXPIRY_DATE ,
      CODE_EXPIRY ,
      SCH_INDX ,
      MAT_DATE ,
      MKT_PRICE ,
      VALUE_DATE,
      MTM_PREV ,
      SECURITY
    )
  SELECT TOTAL_MTM_DEAL_SEQ.NEXTVAL ,
    NSE_CODE ,
    SCHEME ,
    INDXFUTURE ,
    UNITS ,
    AVG_PRICE ,
    MARKET_VALUE ,
    LIABILITY_COST ,
    MTM_PRICE ,
    EXPIRY_DATE ,
    CODE_EXPIRY ,
    SCH_INDX ,
    MAT_DATE ,
    MKT_PRICE ,
    VALUE_DATE,
    MTM_PREV ,
    SECURITY
  FROM HV_TOTAL_MTM;
  END;

/
