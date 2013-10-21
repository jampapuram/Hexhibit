--------------------------------------------------------
--  File created - Friday-October-18-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure SP_DCB_LOAN_MGT_RATIOS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "RIGEL"."SP_DCB_LOAN_MGT_RATIOS" AS
/* This prcedure populates data requied for Foreclosure Ratios */

v_account_id VARCHAR2(50);
v_tenor number(8);
v_disb_dt      date;
v_maturity_dt  date;
v_cutoff_dt    date;

v_txn_type_id Number;
v_txn_type_desc1 VARCHAR2(50);
v_txn_dt date;
v_txn_amt Number(16,2);
v_cif_id  VARCHAR2(50);
v_application_no VARCHAR2(50);
v_FORECLOSURE_STATUS VARCHAR2(50);
v_FORECLOSURE_REASON_DESC1 VARCHAR2(4000);
v_FORECLOSURE_STATUS_DT date;


/* First cursor */
/* Fetch all records which have less than 6 months data and old loans */

  CURSOR C0
  is 
  SELECT HAS.account_id
  FROM HI_ACCOUNT_SNAPSHOT HAS
  WHERE  EXISTS
  (SELECT HAS2.TXN_DT FROM HI_ACCOUNT_SNAPSHOT HAS2 WHERE HAS2.TXN_DT = '01-Mar-13'
   AND HAS.account_id=HAS2.account_id
  )
  AND HAS.TXN_DT BETWEEN '01-Mar-13' AND '01-Aug-13'
  AND HAS.ORG_ID = 777
  
  GROUP BY HAS.account_id
  HAVING COUNT(HAS.account_id) < 6;

BEGIN
   SELECT to_date('31-aug-13','dd-mon-yy') 
   INTO   v_cutoff_dt
   FROM   DUAL;
   
  
   Open c0;
   LOOP
      Fetch c0 into v_account_id;
	    EXIT WHEN c0%NOTFOUND;

  BEGIN
    SELECT nvl(expiry_dt, sysdate) INTO v_maturity_dt
    FROM hi_facilities_dtls
    WHERE account_id = v_account_id
    AND   active = 'Y';
    EXCEPTION WHEN NO_DATA_FOUND THEN v_maturity_dt := sysdate; 
  END;

  
  IF v_maturity_dt > v_cutoff_dt THEN
  /* Loan has been foreclosed */
    v_txn_type_id := 202;
    v_txn_type_desc1 := 'FORECLOSURE';
    v_FORECLOSURE_STATUS := 'Y';
    v_FORECLOSURE_REASON_DESC1 := 'NOT PROVIDED';
    v_FORECLOSURE_STATUS_DT := v_txn_dt;
    
  ELSE
  /* Loan has matured */
    v_txn_type_id := 201;
    v_txn_type_desc1 := 'MATURED';
    v_FORECLOSURE_STATUS := 'N';
    v_FORECLOSURE_REASON_DESC1 := null;
    v_FORECLOSURE_STATUS_DT := null;
  END IF;

BEGIN
    SELECT HAS1.CIF_ID, HAS1.APPLICATION_NO, HAS1.TXN_DT ,
    HAS1.total_prin_os_base_amount 
    INTO v_cif_id, v_application_no, v_txn_dt, v_txn_amt
    FROM HI_ACCOUNT_SNAPSHOT HAS1
    WHERE HAS1.ORG_ID = 777
    AND HAS1.account_id = v_account_id
    AND has1.txn_dt = 
    (SELECT max(has.txn_dt)
     FROM HI_ACCOUNT_SNAPSHOT HAS
     WHERE HAS.ORG_ID = 777
     AND HAS.account_id = HAS1.account_id
     AND nvl(HAS.total_prin_os_base_amount,0) <> 0
     );
    EXCEPTION WHEN NO_DATA_FOUND THEN 
    BEGIN
    v_cif_id := 'ZZZ';
    v_application_no := '999';
    v_txn_dt := sysdate;
    v_txn_amt := 0;
    END; 

END;
  
  INSERT INTO HI_ACCOUNT_TXN
  (
   ORG_ID,
   CIF_ID,
   APPLICATION_NO,
   ACCOUNT_ID,
   AT_ID,
   TXN_DT,
   TXN_TYPE_ID,
   TXN_TYPE_DESC1,
   BASE_CURRENCY_CODE,
   TXN_CURRENCY_CODE,
   BASE_AMOUNT,
   TXN_AMOUNT
   )
   values
   (
   777,
   v_CIF_ID,
   v_APPLICATION_NO,
   v_ACCOUNT_ID,
   ATID_seq.nextval,
   v_TXN_DT,
   v_TXN_TYPE_ID,
   v_TXN_TYPE_DESC1,
   'INR',
   'INR',
   v_txn_amt,
   v_txn_amt
   );

UPDATE HI_ACCOUNT
SET ACCOUNT_STATUS = 'CLOSED',
    REASON_OF_STATUS_CHANGE = 'NO DATA IN SIX_ASOF',
    STATUS_CHANGE_DT = v_txn_dt,
    FORECLOSURE_STATUS = v_FORECLOSURE_STATUS,
    FORECLOSURE_REASON_DESC1 = v_FORECLOSURE_REASON_DESC1,
    FORECLOSURE_STATUS_DT = v_FORECLOSURE_STATUS_DT
WHERE account_id = v_account_id;

COMMIT;
   END LOOP; -- C0 end loop
      close c0;
END;

/
