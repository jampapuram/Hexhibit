--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure HPROC_DIVIDEND
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE HPROC_DIVIDEND 
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
  UTL_FILE.FGETATTR('HG_HAMC_PUMP_DIR', 'DIVIDEND.CSV', V_EXISTS, V_LENGTH, V_BLOCKSIZE);
  IF V_EXISTS THEN
    /*
    NEED TO CHECK THE DATA SO THAT THE DATA DOES NOT GET INSERTED INTO THE TEMPOPARY TABLE
    MULTIPLE TIMES EVEN IF THE PROCEDURE IS RUNNED MULTIPLE TIMES
    */
    SELECT COUNT(*)
    INTO V_COUNT
    FROM HPER_DIVIDEND HPER_DIVIDEND,
      HTMP_DIVIDEND_EXT HTMP_DIVIDEND_EXT
    WHERE HPER_DIVIDEND.SCHEME        = HTMP_DIVIDEND_EXT.SCHEME
    AND HPER_DIVIDEND.VALUE_DATE      = HTMP_DIVIDEND_EXT.VALUE_DATE
    AND HPER_DIVIDEND.SCHEME_CLASS    = HTMP_DIVIDEND_EXT.SCHEME_CLASS
    AND HPER_DIVIDEND.EX_DIVIDEND_NAV = HTMP_DIVIDEND_EXT.EX_DIVIDEND_NAV
    AND HPER_DIVIDEND.PU_DIVIDEND_NAV = HTMP_DIVIDEND_EXT.PU_DIVIDEND_NAV
    AND HPER_DIVIDEND.UPLOAD_DT       = SYSDATE;
    IF V_COUNT                        < 1 THEN
      /*
      INSERTING THE DATA FROM THE TEMPORARY TABLE INTO THE PERMANENT TABLE
      */
      INSERT
      INTO HPER_DIVIDEND
        (
          SCHEME,
          VALUE_DATE,
          SCHEME_CLASS,
          EX_DIVIDEND_NAV,
          PU_DIVIDEND_NAV,
          UPLOAD_DT,
          STATUS
        )
      SELECT HTMP_DIVIDEND_EXT.SCHEME,
        HTMP_DIVIDEND_EXT.VALUE_DATE,
        HTMP_DIVIDEND_EXT.SCHEME_CLASS,
        HTMP_DIVIDEND_EXT.EX_DIVIDEND_NAV,
        HTMP_DIVIDEND_EXT.PU_DIVIDEND_NAV,
        SYSDATE,
        'A'
      FROM HTMP_DIVIDEND_EXT;
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
    FROM HPER_DIVIDEND HPER_DIVIDEND,
      HUPD_DIVIDEND HUPD_DIVIDEND
    WHERE HUPD_DIVIDEND.SCHEME        = HPER_DIVIDEND.SCHEME
    AND HPER_DIVIDEND.VALUE_DATE      = HUPD_DIVIDEND.VALUE_DATE
    AND HPER_DIVIDEND.SCHEME_CLASS          = HUPD_DIVIDEND.SCHEME_CLASS
    AND HPER_DIVIDEND.EX_DIVIDEND_NAV = HUPD_DIVIDEND.EX_DIVIDEND_NAV
    AND HPER_DIVIDEND.PU_DIVIDEND_NAV = HUPD_DIVIDEND.PU_DIVIDEND_NAV;
    IF V_CNT                          < 1 THEN
      /*
      INSERTING THE DATA FROM PERMANENT TABLE TO HI TABLES SINCE WE NEED TO TRUNCATE THE PERMANENT TABLE
      REGULARLY AND ALSO WE WILL PICK ONLY SELECTED COLUMNS IN THE HI TABLE .
      */
      INSERT
      INTO HUPD_DIVIDEND
        (
          DIVIDEND_ID,
          SCHEME,
          VALUE_DATE,
          SCHEME_CLASS,
          EX_DIVIDEND_NAV,
          PU_DIVIDEND_NAV,
          UPLOAD_DT
        )
      SELECT CAMS_SEQ.NEXTVAL,
        SCHEME,
        VALUE_DATE,
        SCHEME_CLASS,
        EX_DIVIDEND_NAV,
        PU_DIVIDEND_NAV,
        SYSDATE
      FROM HPER_DIVIDEND;
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
    WHERE PROCEDURE_NAME = 'HPROC_DIVIDEND'
    AND TABLE_NAME       = 'HUPD_DIVIDEND'
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
        'HPROC_DIVIDEND' AS PROC_NAME,
        'HUPD_DIVIDEND'  AS TABLE_NAME,
        NULL             AS REP0_NAME,
        'Y'              AS PROCEDURE_FLAG,
        'Y'              AS TABLE_FLAG,
        NULL             AS REPO_FLAG,
        SYSDATE          AS AUDIT_DT
      FROM DUAL;
      COMMIT;
    ELSE
      RAISE EX_UPLOAD;
    END IF;
    /*
    AFTER INSERTING THE DATA THE PERMANENT TABLE SHOULD BE REFERESED PERIODICALLY
    FOR EXAMPLE WE ARE DELETING THE RECORDS WHICH ARE GREATER THAN A WEEK FOR THIS TABLE.
    DELETE
    FROM HPER_DIVIDEND
    WHERE UPD_DT >= TRUNC (UPD_DT) - 7;
    COMMIT;*/
    UTL_FILE.FREMOVE ('HG_HAMC_PUMP_DIR', 'DIVIDEND.CSV');
  ELSE
    RAISE FILE_NOTFOUND;
  END IF;
EXCEPTION
WHEN EX_UPLOAD THEN
  RAISE_APPLICATION_ERROR(-20001,'DATA IS ALREADY UPLOADED IN THE SYSTEM FOR TODAY. YOU WILL NOT BE ABLE TO UPLOAD THE FILE FOR TODAY PLEASE TRY TO UPLOAD THE TOMORROW.');
WHEN FILE_NOTFOUND THEN
  RAISE_APPLICATION_ERROR(-20002,'FILE NOT FOUND IN THE DIRECTORY.');
END HPROC_DIVIDEND;

/
