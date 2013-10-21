--------------------------------------------------------
--  File created - Friday-October-18-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure SP_UPD_FAC_PROD
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "RIGEL"."SP_UPD_FAC_PROD" AS

/* this procedure updates product code in Facilities table */

v_account_id VARCHAR2(50);
v_product_code  VARCHAR2(50);


  
/* First cursor */
  CURSOR C0
  is 
SELECT HAF.ACCOUNT_ID,
(CASE 
WHEN SUBSTR(HAF.PRODUCT_CODE,1,4) <> 'CITI'
THEN
  HAF.Product_Code || (CASE
  WHEN HAT.txn_dt < to_date('01-sep-09','dd-mon-yy') THEN '_OLD'
  WHEN HAT.txn_dt >= to_date('01-sep-09','dd-mon-yy') THEN '_NEW'
  END) 
ELSE  HAF.PRODUCT_CODE
END)
FROM HI_APPLICATION_FACILITIES HAF,
HI_ACCOUNT_TXN HAT
WHERE haf.application_no = hat.application_no
AND hat.TXN_TYPE_ID =101
AND haf.org_id =777
AND HAF.ACCOUNT_ID = HAT.ACCOUNT_ID
order by 1;

BEGIN
   Open c0;
   loop
      Fetch c0 into v_account_id,  v_product_code;
	EXIT WHEN c0%NOTFOUND;

update hi_application_facilities
set PRODUCT_CODE = v_product_code 
WHERE account_id = v_account_id;

COMMIT;
   END LOOP; -- C0 end loop
      close c0;
END;

/
