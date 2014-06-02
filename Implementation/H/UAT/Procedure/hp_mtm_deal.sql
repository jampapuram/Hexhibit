--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure HP_MTM_DEAL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE HP_MTM_DEAL 
AS
BEGIN
  INSERT
  INTO HI_MTM_DEAL
    (
      MTM_DEAL_ID,
      NSE_CODE,
      SCHEME,
      INDXFUTURE,
      VALUE_DATE,
      TRAN_TYPE,
      UNITS,
      RATE,
      SCH_INDXFUT,
      EXPIRY_DATE,
      CODE_EXPIRY,
      MKT_PRICE,
      DEAL_MOVEMENT,
      FF_D1
    )
  SELECT MTM_DEAL_SEQ.NEXTVAL ,
    NSE_CODE,
    SCHEME,
    INDXFUTURE,
    VALUE_DATE,
    TRAN_TYPE,
    UNITS,
    RATE,
    SCH_INDXFUT,
    EXPIRY_DATE,
    CODE_EXPIRY,
    MKT_PRICE,
    DEAL_MOVEMENT,
    UPLOAD_DATE
  FROM HV_MTM_DEAL;
END;

/
