--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure HPROC_LIMIT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE HPROC_LIMIT 
AS
  V_COUNT       NUMBER;
  EX_UPLOAD     EXCEPTION;
  FILE_NOTFOUND EXCEPTION;
  V_CNT         NUMBER;
  V_EXISTS      BOOLEAN;
  V_LENGTH      NUMBER;
  V_BLOCKSIZE   NUMBER;
  V_AUDIT       NUMBER;
BEGIN
  UTL_FILE.FGETATTR('HG_HAMC_PUMP_DIR', 'LIMIT.CSV', V_EXISTS, V_LENGTH, V_BLOCKSIZE);
  IF V_EXISTS THEN
    /*
    NEED TO CHECK THE DATA SO THAT THE DATA DOES NOT GET INSERTED INTO THE TEMPOPARY TABLE
    MULTIPLE TIMES EVEN IF THE PROCEDURE IS RUNNED MULTIPLE TIMES
    */
    SELECT COUNT(*)
    INTO V_COUNT
    FROM HPER_LIMIT HPER_LIMIT,
      HTMP_LIMIT_EXT HTMP_LIMIT_EXT
    WHERE HPER_LIMIT.SCHEME     = HTMP_LIMIT_EXT.SCHEME
    AND HPER_LIMIT.PREV_LIMIT   = HTMP_LIMIT_EXT.PREV_LIMIT
    AND HPER_LIMIT.DEBT_AMC     = HTMP_LIMIT_EXT.DEBT_AMC
    AND HPER_LIMIT.LUMPSUM      = HTMP_LIMIT_EXT.LUMPSUM
    AND HPER_LIMIT.LOAD_EXP     = HTMP_LIMIT_EXT.LOAD_EXP
    AND HPER_LIMIT.PREV_EXPENSE = HTMP_LIMIT_EXT.PREV_EXPENSE
    AND HPER_LIMIT.PREV_MTD     = HTMP_LIMIT_EXT.PREV_MTD
    AND HPER_LIMIT.LIMITS       = HTMP_LIMIT_EXT.LIMITS
    AND HPER_LIMIT.SUMMARY      = HTMP_LIMIT_EXT.SUMMARY
    AND HPER_LIMIT.MTD_ASSET    = HTMP_LIMIT_EXT.MTD_ASSET
    AND HPER_LIMIT.UPD_DT       = SYSDATE;
    IF V_COUNT                  < 1 THEN
      /*
      INSERTING THE DATA FROM THE TEMPORARY TABLE INTO THE PERMANENT TABLE
      */
      INSERT
      INTO HPER_LIMIT
        (
          SCHEME,
          PREV_LIMIT,
          DEBT_AMC,
          LUMPSUM,
          LOAD_EXP,
          PREV_EXPENSE,
          PREV_MTD,
          LIMITS,
          SUMMARY,
          MTD_ASSET,
          UPD_DT,
          VALUE_DATE,
          STATUS
        )
      SELECT HTMP_LIMIT_EXT.SCHEME,
        HTMP_LIMIT_EXT.PREV_LIMIT,
        HTMP_LIMIT_EXT.DEBT_AMC,
        HTMP_LIMIT_EXT.LUMPSUM,
        HTMP_LIMIT_EXT.LOAD_EXP,
        HTMP_LIMIT_EXT.PREV_EXPENSE,
        HTMP_LIMIT_EXT.PREV_MTD,
        HTMP_LIMIT_EXT.LIMITS,
        HTMP_LIMIT_EXT.SUMMARY,
        HTMP_LIMIT_EXT.MTD_ASSET,
        SYSDATE,
        SYSDATE,
        'A'
      FROM HTMP_LIMIT_EXT;
      COMMIT;
    ELSE
      /*
      NEED TO THROW AN EXCEPTION IF THE RECORD ALREADY EXISTS.
      */
      RAISE EX_UPLOAD;
    END IF;
    /*
    NEED TO CHECK THE DATA SO THAT THE DATA DOES NOT GET INSERTED INTO THE PERMENANT TABLE
    MULTIPLE TIMES EVEN IF THE PROCEDURE IS RUNNED MULTIPLE TIMES
    */
    SELECT COUNT(*)
    INTO V_CNT
    FROM HPER_LIMIT HPER_LIMIT,
      HUPD_LIMIT_UPLOAD HUPD_LIMIT_UPLOAD
    WHERE HUPD_LIMIT_UPLOAD.SCHEME = HPER_LIMIT.SCHEME
    AND HPER_LIMIT.PREV_LIMIT      = HUPD_LIMIT_UPLOAD.PREV_LIMIT
    AND HPER_LIMIT.DEBT_AMC        = HUPD_LIMIT_UPLOAD.DEBT_AMC
    AND HPER_LIMIT.LUMPSUM         = HUPD_LIMIT_UPLOAD.LUMPSUM
    AND HPER_LIMIT.LOAD_EXP        = HUPD_LIMIT_UPLOAD.LOAD_EXP
    AND HPER_LIMIT.PREV_EXPENSE    = HUPD_LIMIT_UPLOAD.PREV_EXPENSE
    AND HPER_LIMIT.PREV_MTD        = HUPD_LIMIT_UPLOAD.PREV_MTD
    AND HPER_LIMIT.LIMITS          = HUPD_LIMIT_UPLOAD.LIMITS
    AND HPER_LIMIT.SUMMARY         = HUPD_LIMIT_UPLOAD.SUMMARY
    AND HPER_LIMIT.MTD_ASSET       = HUPD_LIMIT_UPLOAD.MTD_ASSET ;
    IF V_CNT                       < 1 THEN
      /*
      INSERTING THE DATA FROM PERMANENT TABLE TO HI TABLES SINCE WE NEED TO TRUNCATE THE PERMANENT TABLE
      REGULARLY AND ALSO WE WILL PICK ONLY SELECTED COLUMNS IN THE HI TABLE .
      */
      INSERT
      INTO HUPD_LIMIT_UPLOAD
        (
          LIMIT_ID,
          SCHEME,
          PREV_LIMIT,
          DEBT_AMC,
          LUMPSUM,
          LOAD_EXP,
          PREV_EXPENSE,
          PREV_MTD,
          LIMITS,
          SUMMARY,
          MTD_ASSET,
          UPD_DT
        )
      SELECT LIMIT_SEQ.NEXTVAL,
        SCHEME,
        PREV_LIMIT,
        DEBT_AMC,
        LUMPSUM,
        LOAD_EXP,
        PREV_EXPENSE,
        PREV_MTD,
        LIMITS,
        SUMMARY,
        MTD_ASSET,
        SYSDATE
      FROM HPER_LIMIT;
      COMMIT;
    ELSE
      RAISE EX_UPLOAD;
    END IF;
    /*
    INSERTING THE DATA IN THE AUDITLOG TABLE FOR FURTHER REFERENCE.
    */
    SELECT COUNT(*)
    INTO V_AUDIT
    FROM HI_AUDITLOG
    WHERE PROCEDURE_NAME = 'HPROC_LIMIT'
    AND TABLE_NAME       = 'HUPD_LIMIT_UPLOAD'
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
        'HPROC_LIMIT'       AS PROC_NAME,
        'HUPD_LIMIT_UPLOAD' AS TABLE_NAME,
        NULL                AS REP0_NAME,
        'Y'                 AS PROCEDURE_FLAG,
        'Y'                 AS TABLE_FLAG,
        NULL                AS REPO_FLAG,
        SYSDATE             AS AUDIT_DT
      FROM DUAL;
      COMMIT;
    ELSE
      RAISE EX_UPLOAD;
    END IF;
    /*
    AFTER INSERTING THE DATA THE PERMANENT TABLE SHOULD BE REFERESED PERIODICALLY
    FOR EXAMPLE WE ARE DELETING THE RECORDS WHICH ARE GREATER THAN A WEEK FOR THIS TABLE.
    DELETE
    FROM HPER_LIMIT
    WHERE UPD_DT >= TRUNC (UPD_DT) - 7;
    COMMIT;*/
    UTL_FILE.FREMOVE ('HG_HAMC_PUMP_DIR', 'LIMIT.CSV');
  ELSE
    RAISE FILE_NOTFOUND;
  END IF;
EXCEPTION
WHEN EX_UPLOAD THEN
  RAISE_APPLICATION_ERROR(-20001,'DATA IS ALREADY UPLOADED IN THE SYSTEM FOR TODAY. YOU WILL NOT BE ABLE TO UPLOAD THE FILE FOR TODAY PLEASE TRY TO UPLOAD THE TOMORROW.');
WHEN FILE_NOTFOUND THEN
  RAISE_APPLICATION_ERROR(-20002,'FILE NOT FOUND IN THE DIRECTORY.');
END HPROC_LIMIT;

/