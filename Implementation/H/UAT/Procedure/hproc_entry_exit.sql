--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure HPROC_ENTRY_EXIT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE HPROC_ENTRY_EXIT 
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
  UTL_FILE.FGETATTR('HG_HAMC_PUMP_DIR', 'ENTRYEXIT.CSV', V_EXISTS, V_LENGTH, V_BLOCKSIZE);
  IF V_EXISTS THEN
    /*
    NEED TO CHECK THE DATA SO THAT THE DATA DOES NOT GET INSERTED INTO THE TEMPOPARY TABLE
    MULTIPLE TIMES EVEN IF THE PROCEDURE IS RUNNED MULTIPLE TIMES
    */
    SELECT COUNT(*)
    INTO V_COUNT
    FROM HPER_ENTRYEXIT HPER_ENTRYEXIT,
      HTMP_ENTRY_EXIT_EXT HTMP_ENTRY_EXIT_EXT
    WHERE HPER_ENTRYEXIT.SCHEME   = HTMP_ENTRY_EXIT_EXT.SCHEME
    AND HPER_ENTRYEXIT.PLAN       = HTMP_ENTRY_EXIT_EXT.PLAN
    AND HPER_ENTRYEXIT.ENTRY_LOAD = HTMP_ENTRY_EXIT_EXT.ENTRY_LOAD
    AND HPER_ENTRYEXIT.EXIT_LOAD  = HTMP_ENTRY_EXIT_EXT.EXIT_LOAD
    AND HPER_ENTRYEXIT.INPUT_DATE = HTMP_ENTRY_EXIT_EXT.INPUT_DATE
    AND HPER_ENTRYEXIT.UPLOAD_DT  = SYSDATE;
    IF V_COUNT                    < 1 THEN
      /*
      INSERTING THE DATA FROM THE TEMPORARY TABLE INTO THE PERMANENT TABLE
      */
      INSERT
      INTO HPER_ENTRYEXIT
        (
          SCHEME,
          PLAN,
          ENTRY_LOAD,
          EXIT_LOAD,
          INPUT_DATE,
          UPLOAD_DT,
          VALUE_DATE,
          STATUS
        )
      SELECT HTMP_ENTRY_EXIT_EXT.SCHEME,
        HTMP_ENTRY_EXIT_EXT.PLAN,
        HTMP_ENTRY_EXIT_EXT.ENTRY_LOAD,
        HTMP_ENTRY_EXIT_EXT.EXIT_LOAD,
        HTMP_ENTRY_EXIT_EXT.INPUT_DATE,
        SYSDATE,
        SYSDATE,
        'A'
      FROM HTMP_ENTRY_EXIT_EXT;
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
    FROM HPER_ENTRYEXIT HPER_ENTRYEXIT,
      HUPD_ENTRY_EXIT_LOAD HUPD_ENTRY_EXIT_LOAD
    WHERE HUPD_ENTRY_EXIT_LOAD.SCHEME = HPER_ENTRYEXIT.SCHEME
    AND HPER_ENTRYEXIT.PLAN           = HUPD_ENTRY_EXIT_LOAD.PLAN
    AND HPER_ENTRYEXIT.ENTRY_LOAD     = HUPD_ENTRY_EXIT_LOAD.ENTRY_LOAD
    AND HPER_ENTRYEXIT.EXIT_LOAD      = HUPD_ENTRY_EXIT_LOAD.EXIT_LOAD
    AND HPER_ENTRYEXIT.INPUT_DATE     = HUPD_ENTRY_EXIT_LOAD.INPUT_DATE;
    IF V_CNT                          < 1 THEN
      /*
      INSERTING THE DATA FROM PERMANENT TABLE TO HI TABLES SINCE WE NEED TO TRUNCATE THE PERMANENT TABLE
      REGULARLY AND ALSO WE WILL PICK ONLY SELECTED COLUMNS IN THE HI TABLE .
      */
      INSERT
      INTO HUPD_ENTRY_EXIT_LOAD
        (
          ENTRY_EXIT_ID,
          SCHEME,
          PLAN,
          ENTRY_LOAD,
          EXIT_LOAD,
          INPUT_DATE,
          UPLOAD_DT
        )
      SELECT ENTRYEXIT_SEQ.NEXTVAL,
        SCHEME,
        PLAN,
        ENTRY_LOAD,
        EXIT_LOAD,
        INPUT_DATE,
        SYSDATE
      FROM HPER_ENTRYEXIT;
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
    WHERE PROCEDURE_NAME = 'HPROC_ENTRY_EXIT'
    AND TABLE_NAME       = 'HUPD_ENTRY_EXIT_LOAD'
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
        'HPROC_ENTRY_EXIT'     AS PROC_NAME,
        'HUPD_ENTRY_EXIT_LOAD' AS TABLE_NAME,
        NULL                   AS REP0_NAME,
        'Y'                    AS PROCEDURE_FLAG,
        'Y'                    AS TABLE_FLAG,
        NULL                   AS REPO_FLAG,
        SYSDATE                AS AUDIT_DT
      FROM DUAL;
      COMMIT;
    ELSE
      RAISE EX_UPLOAD;
    END IF;
    /*
    AFTER INSERTING THE DATA THE PERMANENT TABLE SHOULD BE REFERESED PERIODICALLY
    FOR EXAMPLE WE ARE DELETING THE RECORDS WHICH ARE GREATER THAN A WEEK FOR THIS TABLE.
    DELETE
    FROM HPER_ENTRYEXIT
    WHERE UPD_DT >= TRUNC (UPD_DT) - 7;
    COMMIT;*/
    UTL_FILE.FREMOVE ('HG_HAMC_PUMP_DIR', 'ENTRYEXIT.CSV');
  ELSE
    RAISE FILE_NOTFOUND;
  END IF;
EXCEPTION
WHEN EX_UPLOAD THEN
  RAISE_APPLICATION_ERROR(-20001,'DATA IS ALREADY UPLOADED IN THE SYSTEM FOR TODAY. YOU WILL NOT BE ABLE TO UPLOAD THE FILE FOR TODAY PLEASE TRY TO UPLOAD THE TOMORROW.');
WHEN FILE_NOTFOUND THEN
  RAISE_APPLICATION_ERROR(-20002,'FILE NOT FOUND IN THE DIRECTORY.');
END HPROC_ENTRY_EXIT;

/
