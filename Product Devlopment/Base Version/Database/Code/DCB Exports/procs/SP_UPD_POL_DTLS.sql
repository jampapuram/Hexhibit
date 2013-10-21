--------------------------------------------------------
--  File created - Friday-October-18-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure SP_UPD_POL_DTLS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "RIGEL"."SP_UPD_POL_DTLS" AS

/* this procedure updates category code code in POLICY_DTLS table */
v_cat_code VARCHAR2(50);
v_policy_desc1 VARCHAR2(4000);
v_rev_cat_code VARCHAR2(50);

  
/* First cursor */
  CURSOR C0
  is 
SELECT CAT_CODE, TRIM(POLICY_DESC), REV_CAT_CODE
FROM POLICY_CATEGORY
ORDER BY 2;


BEGIN
   Open c0;
   loop
      Fetch c0 into v_cat_code, v_policy_desc1 , v_rev_cat_code;
	EXIT WHEN c0%NOTFOUND;

  UPDATE HI_APPLICATION_POLICY_DTLS
  SET POLICY_DEV_REASON_CODE = v_rev_cat_code,
      POLICY_DEV_REASON_DESC1 = v_rev_cat_code,
      POLICY_DEV_REASON_DESC2 = v_cat_code
  WHERE upper(TRIM(FF_VC2)) = upper(TRIM(v_policy_desc1));

COMMIT;
   END LOOP; -- C0 end loop
      close c0;
END;

/
