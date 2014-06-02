--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HTMP_ENTRY_EXIT_EXT
--------------------------------------------------------

  CREATE TABLE HTMP_ENTRY_EXIT_EXT 
   (	SCHEME VARCHAR2(100 BYTE), 
	PLAN VARCHAR2(100 BYTE), 
	ENTRY_LOAD NUMBER(21,5), 
	EXIT_LOAD NUMBER(21,5), 
	INPUT_DATE DATE
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY HG_HAMC_PUMP_DIR
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE FIELDS TERMINATED BY ',' MISSING FIELD VALUES ARE NULL REJECT ROWS
WITH ALL NULL FIELDS (SCHEME,PLAN,ENTRY_LOAD,EXIT_LOAD,INPUT_DATE)     )
      LOCATION
       ( 'ENTRYEXIT.CSV'
       )
    );


