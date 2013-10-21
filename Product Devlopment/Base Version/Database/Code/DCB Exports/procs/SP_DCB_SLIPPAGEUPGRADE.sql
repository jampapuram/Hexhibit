--------------------------------------------------------
--  File created - Friday-October-18-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure SP_DCB_SLIPPAGEUPGRADE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "RIGEL"."SP_DCB_SLIPPAGEUPGRADE" AS
/* This prcedure populates data in HI_ACCOUNT_SNAPSHOT requied for Slippage, Upgrade Ratios */

/* Before executing this procedure
we need to UPDATE HI_ACCOUNT_SNAPSHOT
and SET FF_N1, FF_VC1, FF_VC2 to NULL
*/

/* Following variables store current values fetched from cursor */
v_account_id_cur VARCHAR2(50);
v_npa_status_cur VARCHAR2(50);
v_txn_dt_cur date;
v_pos_base_amount_cur NUMBER(16,2);
v_seq_cur number(4);

/* Following variables store previous values fetched from cursor */
v_account_id_prev VARCHAR2(50);
v_npa_status_prev VARCHAR2(50);
v_txn_dt_prev date;
v_pos_base_amount_prev NUMBER(16,2);
v_seq_prev number(4);

/* Following variables store the computed values */

v_recovery_amt NUMBER(16,2);
v_recovery_type VARCHAR2(50);
v_upgrade_type VARCHAR2(50);
v_hcd_count NUMBER(8);

/* First cursor */
/* Fetch all records */

  CURSOR C0
  is 
  SELECT HA.account_id, HA.npa_status, HAS.TXN_DT, nvl(has.total_prin_os_base_amount,0),oth.seq_no
  FROM HI_ACCOUNT HA, HI_ACCOUNT_SNAPSHOT HAS ,um_mapping_others oth
  WHERE HA.ACCOUNT_ID = HAS.ACCOUNT_ID
  AND   HA.ACTIVATION_DT = HAS.TXN_DT
  --AND HA.ACCOUNT_ID = '1028563'
  AND HA.ORG_ID = HAS.ORG_ID
  AND HA.ORG_ID = 777
  and oth.org_id= HA.ORG_ID
  and oth.level_id=1124
  AND HA.NPA_STATUS = oth.target_desc1
  order by 1, 3;

BEGIN
   
   v_account_id_prev := 'ZZZ';
  
   Open c0;
   LOOP
      Fetch c0 into v_account_id_cur , v_npa_status_cur, v_txn_dt_cur, v_pos_base_amount_cur,v_seq_cur ;
	    EXIT WHEN c0%NOTFOUND;
      
      IF v_account_id_prev <> 'ZZZ' THEN 
          BEGIN
            IF v_account_id_cur = v_account_id_prev THEN
               -- Compare current POS with Prev POS
                    v_recovery_amt := v_pos_base_amount_prev - v_pos_base_amount_cur;
                    v_upgrade_type := null;
                    
                    IF v_pos_base_amount_cur <= v_pos_base_amount_prev THEN
                        
                        IF V_SEQ_CUR > V_SEQ_PREV THEN
                                       
                            v_recovery_type :='SLIPPAGE';
                          
                        ELSIF V_SEQ_CUR < V_SEQ_PREV AND V_SEQ_CUR=1 THEN
                               v_recovery_type :='UPGRADE';
                               IF v_pos_base_amount_cur = 0 THEN
                                  v_upgrade_type := 'UPGRADE AND CLOSED';
                                ELSE
                                  v_upgrade_type := 'UPGRADE AND STANDARD';
                               END IF;
                               
                        ELSE
                              -- We have to consider only those cases who are delinquent
                              -- and have DPD > 0 
                              
                              SELECT count(*) INTO v_hcd_count
                              FROM HI_COLLECTION_DPD HCD
                              WHERE HCD.ACCOUNT_ID = v_account_id_cur
                              AND   HCD.EFFECTIVE_DT = v_txn_dt_cur
                              AND   HCD.ORG_ID = 777;
                              
                              IF v_hcd_count > 0 THEN
                                 v_recovery_type :='NORMAL RECOVERY';
                              ELSE
                                 v_recovery_type := null;
                              END IF;
                              
                        END IF;
                              
                  -- recovery has happened now check type of recovery and set to v_recovery_type
                      IF v_recovery_type is NOT NULL THEN
                          UPDATE HI_ACCOUNT_SNAPSHOT
                          SET FF_N1 = v_recovery_amt , FF_VC1 = v_recovery_type, FF_VC2 = v_upgrade_type 
                          WHERE Account_id = v_account_id_cur 
                          AND TXN_DT = v_txn_dt_cur 
                          AND ORG_ID=777 ;
                      END IF;
                 END IF;    
            ELSE
            -- account id has changed so we don't do anything
               null;
            END IF;
            
          END;
          
      END IF;
      v_account_id_prev := v_account_id_cur;
      v_npa_status_prev := v_npa_status_cur;
      v_txn_dt_prev     :=  v_txn_dt_cur;
      v_pos_base_amount_prev := v_pos_base_amount_cur;
      v_seq_prev := v_seq_cur;

  
   END LOOP; -- C0 end loop
      close c0;
END;

/
