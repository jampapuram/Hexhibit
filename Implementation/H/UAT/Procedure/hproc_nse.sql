--------------------------------------------------------
--  File created - Thursday-May-29-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure HPROC_NSE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE HPROC_NSE 
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
  UTL_FILE.FGETATTR('HG_HAMC_PUMP_DIR', 'NSE.csv', V_EXISTS, V_LENGTH, V_BLOCKSIZE);
  IF v_exists THEN
    /*
    Need to check the data so that the data does not get inserted into the tempopary table
    multiple times even if the procedure is runned multiple times
    */
    SELECT COUNT(*)
    INTO V_COUNT
    FROM HPER_NSE HPER_NSE,
      HTMP_NSE_EXT HTMP_NSE_EXT
    WHERE HPER_NSE.SYMBOL    = HTMP_NSE_EXT.SYMBOL
    AND HPER_NSE.SERIES      = HTMP_NSE_EXT.SERIES
    AND HPER_NSE.OPEN        = HTMP_NSE_EXT.OPEN
    AND HPER_NSE.HIGH        = HTMP_NSE_EXT.HIGH
    AND HPER_NSE.LOW         = HTMP_NSE_EXT.LOW
    AND HPER_NSE.CLOSE       = HTMP_NSE_EXT.CLOSE
    AND HPER_NSE.LAST        = HTMP_NSE_EXT.LAST
    AND HPER_NSE.PREVCLOSE   = HTMP_NSE_EXT.PREVCLOSE
    AND HPER_NSE.TOTTRDQTY   = HTMP_NSE_EXT.TOTTRDQTY
    AND HPER_NSE.TOTTRDVAL   = HTMP_NSE_EXT.TOTTRDVAL
    AND HPER_NSE.NSE_DATE    = HTMP_NSE_EXT.NSE_DATE
    AND HPER_NSE.TOTALTRADES = HTMP_NSE_EXT.TOTALTRADES
    AND HPER_NSE.ISIN        = HTMP_NSE_EXT.ISIN
    AND HPER_NSE.UPD_DT      = SYSDATE;
    IF V_COUNT               < 1 THEN
      /*
      Inserting the data from the temporary table into the permanent table
      */
      INSERT
      INTO HPER_NSE
        (
          SYMBOL,
          SERIES,
          OPEN,
          HIGH,
          LOW,
          CLOSE,
          LAST,
          PREVCLOSE,
          TOTTRDQTY,
          TOTTRDVAL,
          NSE_DATE,
          TOTALTRADES,
          ISIN,
          UPD_DT,
          --VALUE_DATE,
          STATUS
        )
      SELECT HTMP_NSE_EXT.SYMBOL,
        HTMP_NSE_EXT.SERIES,
        HTMP_NSE_EXT.OPEN,
        HTMP_NSE_EXT.HIGH,
        HTMP_NSE_EXT.LOW,
        HTMP_NSE_EXT.CLOSE,
        HTMP_NSE_EXT.LAST,
        HTMP_NSE_EXT.PREVCLOSE,
        HTMP_NSE_EXT.TOTTRDQTY,
        HTMP_NSE_EXT.TOTTRDVAL,
        HTMP_NSE_EXT.NSE_DATE,
        HTMP_NSE_EXT.TOTALTRADES,
        HTMP_NSE_EXT.ISIN,
        SYSDATE,
        --SYSDATE,
        'A'
      FROM HTMP_NSE_EXT;
      COMMIT;
    ELSE
      /*
      Need to throw an exception if the record already exists.
      */
      RAISE EX_UPLOAD;
    END IF;
    /*
    Need to check the data so that the data does not get inserted into the permenant table
    multiple times even if the procedure is runned multiple times
    */
    SELECT COUNT(*)
    INTO V_CNT
    FROM HPER_NSE HPER_NSE,
      HI_NSE HI_NSE
    WHERE HI_NSE.NSE_CODE = HPER_NSE.SYMBOL
    AND HI_NSE.NSE_CLOSE  = HPER_NSE.CLOSE
    AND HI_NSE.NSE_SERIES = HPER_NSE.SERIES
    AND HI_NSE.ISIN_CODE  = HPER_NSE.ISIN
    AND HI_NSE.NSE_DT     = HPER_NSE.NSE_DATE;
    IF V_CNT              < 1 THEN
      /*
      INSERTING THE DATA FROM PERMANENT TABLE TO HI TABLES SINCE WE NEED TO TRUNCATE THE PERMANENT TABLE
      REGULARLY AND ALSO WE WILL PICK ONLY SELECTED COLUMNS IN THE HI TABLE .
      */
      INSERT
      INTO HI_NSE
        (
          NSE_ID,
          NSE_CODE,
          NSE_CLOSE,
          NSE_SERIES,
          ISIN_CODE,
          NSE_DT
        )
      SELECT NSE_SEQ.NEXTVAL, SYMBOL, CLOSE,SERIES,ISIN,NSE_DATE FROM HPER_NSE;
      COMMIT;
    ELSE
      RAISE EX_UPLOAD;
    END IF;
    /*
    INSERTING THE DATA IN THE AUDITLOG TABLE FOR FURTHER REFERENCE.
    */
    SELECT COUNT(*)
    INTO v_audit
    FROM HI_AUDITLOG
    WHERE PROCEDURE_NAME = 'HPROC_NSE'
    AND TABLE_NAME       = 'HI_NSE'
    AND AUDIT_DT         = SYSDATE
    AND PROCEDURE_FLAG   = 'Y';
    IF V_AUDIT           < 1 THEN
      INSERT
      INTO HI_AUDITLOG
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
        'HPROC_NSE' AS PROC_NAME,
        'HI_NSE'    AS TABLE_NAME,
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
    FROM HPER_NSE
    WHERE UPD_DT >= TRUNC (UPD_DT) - 7;
    COMMIT;*/
    UTL_FILE.FREMOVE ('HG_HAMC_PUMP_DIR', 'NSE.csv');
  ELSE
    RAISE FILE_NOTFOUND;
  END IF;
EXCEPTION
WHEN EX_UPLOAD THEN
  RAISE_APPLICATION_ERROR(-20001,'Data is already uploaded in the system for today. You will not be able to upload the file for today please try to upload the tomorrow.');
WHEN FILE_NOTFOUND THEN
  RAISE_APPLICATION_ERROR(-20002,'File not found in the directory.');
END HPROC_NSE;

/
