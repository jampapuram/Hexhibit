--------------------------------------------------------
--  File created - Friday-October-18-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure SP_UPD_HAS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "RIGEL"."SP_UPD_HAS" AS
/* This prcedure populates Previous month POS in HI_ACCOUNT_SNAPSHOT */

/* Before executing this procedure
we need to UPDATE HI_ACCOUNT_SNAPSHOT
and SET FF_N2 to 0
*/

/* Following variables store current values fetched from cursor */
v_account_id_cur VARCHAR2(50);
v_txn_dt_cur date;
v_pos_base_amount_cur NUMBER(16,2);

/* Following variables store previous values fetched from cursor */
v_account_id_prev VARCHAR2(50);
v_txn_dt_prev date;
v_pos_base_amount_prev NUMBER(16,2);

/* Following variables store the computed values */


lv_out_mesg VARCHAR2(4000);

/* First cursor */
/* Fetch all records */

  CURSOR C0
  is 
  SELECT HAS.account_id, HAS.TXN_DT, nvl(has.total_prin_os_base_amount,0)
  FROM  HI_ACCOUNT_SNAPSHOT HAS
  WHERE
 -- HAS.ACCOUNT_ID = '1028563'
-- AND 
   HAS.ORG_ID = 777
  order by 1, 2;

BEGIN
   
   v_account_id_prev := 'ZZZ';
  
   Open c0;
   LOOP
      Fetch c0 into v_account_id_cur ,v_txn_dt_cur, v_pos_base_amount_cur ;
	    EXIT WHEN c0%NOTFOUND;
      
      IF v_account_id_prev <> 'ZZZ' THEN 
          BEGIN
            IF v_account_id_cur = v_account_id_prev THEN
               -- Compare current POS with Prev POS
                    
                          UPDATE HI_ACCOUNT_SNAPSHOT
                          SET FF_N2 = v_pos_base_amount_prev 
                          WHERE Account_id = v_account_id_cur 
                          AND TXN_DT = v_txn_dt_cur
                          AND ORG_ID=777 ;
                           
                      --    commit;
             ELSE
            -- account id has changed so we don't do anything
               null;
            END IF;
            EXCEPTION WHEN OTHERS then 
            begin
              lv_out_mesg := ' ' || sqlerrm ;
              INSERT INTO DUMMY_FOR_PROC
              ( rundate, seq_no, msg)
              VALUES
               (Sysdate,1,
               'Account_ID : ' || v_account_id_cur || ' :: ' || lv_out_mesg
                );
            end;
          END;
          COMMIT;
      END IF;
      v_account_id_prev := v_account_id_cur;
      v_txn_dt_prev     :=  v_txn_dt_cur;
      v_pos_base_amount_prev := v_pos_base_amount_cur;
    
  
   END LOOP; -- C0 end loop
      close c0;
END;

/
