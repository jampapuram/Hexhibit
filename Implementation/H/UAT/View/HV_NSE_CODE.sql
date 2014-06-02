
  CREATE OR REPLACE  VIEW HV_NSE_CODE (STK_SEC_ID, SECURITY, NSE_CODE) AS 
  select hsec.stk_sec_id,hsec.SECURITY,
SUBSTR (hsec.STK_SEC_ID,3) NSE_CODE
from HM_security hsec;
 
