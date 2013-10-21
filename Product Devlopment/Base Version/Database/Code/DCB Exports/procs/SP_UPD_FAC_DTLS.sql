--------------------------------------------------------
--  File created - Friday-October-18-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure SP_UPD_FAC_DTLS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "RIGEL"."SP_UPD_FAC_DTLS" AS


v_activation_dt      date;
v_account_id VARCHAR2(50);


  
/* First cursor */
  CURSOR C0
  is 
select account_id, max(activation_dt)
from HI_facilities_dtls
group by account_id
order by 1;

BEGIN
   Open c0;
   loop
      Fetch c0 into v_account_id,  v_activation_dt;
	EXIT WHEN c0%NOTFOUND;

update HI_facilities_dtls
set ACTIVE = 'Y',
DEACTIVATION_DT = to_date('31-dec-4099', 'dd-mon-yyyy')
WHERE account_id = v_account_id
AND   activation_dt = v_activation_dt;

COMMIT;
   END LOOP; -- C0 end loop
      close c0;
END;

/
