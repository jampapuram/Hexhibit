--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure HPROC_BSE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE HPROC_BSE 
AS
  V_COUNT       NUMBER;
  EX_UPLOAD     EXCEPTION;
  FILE_NOTFOUND EXCEPTION;
  V_CNT         NUMBER;
  V_EXISTS      BOOLEAN;
  V_LENGTH      NUMBER;
  V_BLOCKSIZE   NUMBER;
  v_audit       NUMBER;
BEGIN
  UTL_FILE.FGETATTR('HG_HAMC_PUMP_DIR', 'BSE.csv', V_EXISTS, V_LENGTH, V_BLOCKSIZE);
  IF v_exists THEN
    /*
    Need to check the data so that the data does not get inserted into the tempopary table
    multiple times even if the procedure is runned multiple times
    */
    SELECT COUNT(*)
    INTO v_count
    FROM HPER_BSE HPER_BSE,
      HTMP_BSE_EXT HTMP_BSE_EXT
    WHERE HPER_BSE.SC_CODE  = HTMP_BSE_EXT.SC_CODE
    AND hper_bse.close      = htmp_bse_ext.close
    AND hper_bse.sc_name    = htmp_bse_ext.sc_name
    AND hper_bse.sc_group   = htmp_bse_ext.sc_group
    AND hper_bse.sc_type    = htmp_bse_ext.sc_type
    AND hper_bse.open       = htmp_bse_ext.open
    AND hper_bse.high       = htmp_bse_ext.high
    AND hper_bse.low        = htmp_bse_ext.low
    AND hper_bse.last       = htmp_bse_ext.last
    AND hper_bse.prevclose  = htmp_bse_ext.prevclose
    AND hper_bse.no_trades  = htmp_bse_ext.no_trades
    AND hper_bse.NO_OF_SHRS = htmp_bse_ext.NO_OF_SHRS
    AND hper_bse.NET_TURNOV = htmp_bse_ext.NET_TURNOV
    AND hper_bse.TDCLOINDI  = htmp_bse_ext.TDCLOINDI
    AND hper_bse.value_date = SYSDATE
    AND hper_bse.UPD_DT     = sysdate;
    IF v_count              < 1 THEN
      /*
      Inserting the data from the tempopary table into the permanent table
      */
      INSERT
      INTO HPER_BSE
        (
          SC_CODE,
          SC_NAME,
          SC_GROUP,
          SC_TYPE,
          OPEN,
          HIGH,
          LOW,
          CLOSE,
          LAST,
          PREVCLOSE,
          NO_TRADES,
          NO_OF_SHRS,
          NET_TURNOV,
          TDCLOINDI,
          UPD_DT,
          VALUE_DATE,
          STATUS
        )
      SELECT HTMP_BSE_EXT.SC_CODE,
        HTMP_BSE_EXT.SC_NAME,
        HTMP_BSE_EXT.SC_GROUP,
        HTMP_BSE_EXT.SC_TYPE,
        HTMP_BSE_EXT.open,
        HTMP_BSE_EXT.high,
        HTMP_BSE_EXT.LOW,
        HTMP_BSE_EXT.close,
        HTMP_BSE_EXT.last,
        HTMP_BSE_EXT.PREVCLOSE,
        HTMP_BSE_EXT.NO_TRADES,
        HTMP_BSE_EXT.NO_OF_SHRS,
        HTMP_BSE_EXT.NET_TURNOV,
        HTMP_BSE_EXT.TDCLOINDI,
        SYSDATE,
        SYSDATE,
        'A'
      FROM HTMP_BSE_EXT;
      COMMIT;
    ELSE
      /*
      Need to throw an exception if the record already exists.
      */
      raise ex_upload;
    END IF;
    /*
    Need to check the data so that the data does not get inserted into the permenant table
    multiple times even if the procedure is runned multiple times
    */
    SELECT COUNT(*)
    INTO v_cnt
    FROM HPER_BSE HPER_BSE,
      HI_BSE HI_BSE
    WHERE HI_BSE.BSE_CODE = hper_bse.SC_CODE
    AND HI_BSE.BSE_CLOSE  = hper_bse.close
    AND HI_BSE.VALUE_DATE = hper_bse.value_date
    AND HI_BSE.UPD_DATE   = hper_bse.upd_dt;
    IF v_cnt              < 1 THEN
      /*
      INSERTING THE DATA FROM PERMANENT TABLE TO HI TABLES SINCE WE NEED TO TRUNCATE THE PERMANENT TABLE
      REGULARLY AND ALSO WE WILL PICK ONLY SELECTED COLUMNS IN THE HI TABLE .
      */
      INSERT
      INTO HI_BSE
        (
          BSE_ID,
          BSE_CODE,
          BSE_CLOSE,
          UPD_DATE,
          VALUE_DATE
        )
      SELECT BSE_SEQ.NEXTVAL, SC_CODE, CLOSE, UPD_DT, VALUE_DATE FROM HPER_BSE;
      COMMIT;
    ELSE
      raise ex_upload;
    END IF;
    /*
    INSERTING THE DATA IN THE AUDITLOG TABLE FOR FURTHER REFERENCE.
    */
    SELECT COUNT(*)
    INTO v_audit
    FROM HI_AUDITLOG
    WHERE PROCEDURE_NAME = 'HPROC_BSE'
    AND TABLE_NAME       = 'HI_BSE'
    AND AUDIT_DT         = SYSDATE
    AND PROCEDURE_FLAG   = 'Y';
    IF V_AUDIT           < 1 THEN
      INSERT
      INTO hi_auditlog
        (
          AUDITLOG_ID,
          PROCEDURE_NAME,
          TABLE_NAME,
          REPO_NAME,
          PROCEDURE_FLAG,
          TABLE_FLAG,
          REPO_FLAG,
          AUDIT_DT
        )
      SELECT AUDIT_SEQ.NEXTVAL ,
        'HPROC_BSE' AS PROC_NAME,
        'HI_BSE'    AS TABLE_NAME,
        NULL        AS REP0_NAME,
        'Y'         AS PROCEDURE_FLAG,
        'Y'         AS TABLE_FLAG,
        NULL        AS REPO_FLAG,
        SYSDATE     AS AUDIT_DT
      FROM DUAL;
      COMMIT;
    ELSE
      RAISE EX_UPLOAD;
    END IF;
    /*
    AFTER INSERTING THE DATA THE PERMANENT TABLE SHOULD BE REFERESED PERIODICALLY
    FOR EXAMPLE WE ARE DELETING THE RECORDS WHICH ARE GREATER THAN A WEEK FOR THIS TABLE.
    DELETE
    FROM HPER_BSE
    WHERE UPD_DT >= TRUNC (UPD_DT) - 7;
    COMMIT;*/
    UTL_FILE.FREMOVE ('HG_HAMC_PUMP_DIR', 'BSE.csv');
  ELSE
    raise FILE_NOTFOUND;
  END IF;
EXCEPTION
WHEN ex_upload THEN
  RAISE_APPLICATION_ERROR(-20001,'Data is already uploaded in the system for today. You will not be able to upload the file for today please try to upload the tomorrow.');
WHEN FILE_NOTFOUND THEN
  RAISE_APPLICATION_ERROR(-20002,'File not found in the directory.');
END HPROC_BSE;

/
