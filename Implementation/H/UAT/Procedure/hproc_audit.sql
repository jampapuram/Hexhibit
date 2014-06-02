--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure HPROC_AUDIT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE HPROC_AUDIT AS 

   v_exists    BOOLEAN;
   v_length    NUMBER;
   v_blocksize NUMBER;
BEGIN 
    UTL_FILE.FGETATTR('HG_HAMC_PUMP_DIR', 'BSE.csv', v_exists, v_length, v_blocksize);
    IF v_exists THEN
       dbms_output.put_line('Length is: '||v_length);
       DBMS_OUTPUT.PUT_LINE('Block size is: '||V_BLOCKSIZE);
        UTL_FILE.FREMOVE ('HG_HAMC_PUMP_DIR', 'BSE.csv');
        dbms_output.put_line('File is removed. ');
    ELSE
      dbms_output.put_line('File not found.'); 
    END IF;
END HPROC_AUDIT;

/
