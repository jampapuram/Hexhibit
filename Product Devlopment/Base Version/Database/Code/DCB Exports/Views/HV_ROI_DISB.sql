--------------------------------------------------------
--  File created - Friday-October-18-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View HV_ROI_DISB
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "RIGEL"."HV_ROI_DISB" ("YEARS", "MONTHS", "ROI_DISB", "DISB_AMT", "ROI_DISB_AMT", "ACCOUNT_ID", "TXN_DT") AS 
  SELECT 
    TO_CHAR(HAS.TXN_DT,'YYYY') YEARS,
    TO_CHAR(HAS.TXN_DT,'MONTH') MONTHS,
    NVL(HAS.FF_N3,0) ROI_DISB,
    HAT.BASE_AMOUNT DISB_AMT,
    NVL((HAS.FF_N3 * HAT.BASE_AMOUNT),0) ROI_DISB_AMT,
    HAT.ACCOUNT_ID,
    hat.txn_dt
    -- ((HAS.FF_N3 * HAT.BASE_AMOUNT)/( HAT.BASE_AMOUNT) ) RATIO,
  FROM HI_ACCOUNT_TXN HAT,
    HI_ACCOUNT_SNAPSHOT HAS
  WHERE HAT.ACCOUNT_ID= HAS.ACCOUNT_ID
  AND HAT.TXN_TYPE_ID = 101
  AND HAT.TXN_DT BETWEEN HAS.ACTIVATION_DT AND HAS.DEACTIVATION_DT;
