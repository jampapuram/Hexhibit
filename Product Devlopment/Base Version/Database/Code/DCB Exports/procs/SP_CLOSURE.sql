--------------------------------------------------------
--  File created - Friday-October-18-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure SP_CLOSURE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "RIGEL"."SP_CLOSURE" AS

/* 
Procedure Name: SP_CLOSURE
Written On    : 18/09/13
Purpose       : Coverage Ratio.
*/
V_PROVISION_AMT NUMBER(16,2);
v_npa_amt Number(16,2);
V_COVERAGE NUMBER (16,2);
v_account_id NUMBER (16,2);


BEGIN
SELECT HA.PROVISIONS_BASE_AMOUNT PROVISION_AMT,
  HA.TOTAL_PRIN_OS_BASE_AMOUNT NPA_AMT,
  (NVL(HA.PROVISIONS_BASE_AMOUNT,0)/NVL(HA.TOTAL_PRIN_OS_BASE_AMOUNT,0)) COVERAGE,
  HA.ACCOUNT_ID
INTO V_PROVISION_AMT,
  v_npa_amt,
  V_COVERAGE,
  v_account_id
FROM HI_ACCOUNT H,
  HI_ACCOUNT_SNAPSHOT HA
WHERE HA.ACCOUNT_ID     = H.ACCOUNT_ID
AND H.ORG_ID            = 777
AND H.FF_D1             = HA.TXN_DT
AND TRIM(H.NPA_STATUS) IN( 'NON-NPA', 'D-2', 'SUB STD', 'D-3', 'D-1', 'LOSS' ) ;
EXCEPTION 
WHEN ZERO_DIVIDE THEN
    null;
END;

/
