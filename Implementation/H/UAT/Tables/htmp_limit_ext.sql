--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HTMP_LIMIT_EXT
--------------------------------------------------------

  CREATE TABLE HTMP_LIMIT_EXT 
   (	SCHEME VARCHAR2(50 BYTE), 
	PREV_LIMIT NUMBER(16,2), 
	DEBT_AMC NUMBER(16,2), 
	LUMPSUM NUMBER(16,2), 
	LOAD_EXP NUMBER(16,2), 
	PREV_EXPENSE NUMBER(16,2), 
	PREV_MTD NUMBER(16,2), 
	LIMITS NUMBER(16,2), 
	SUMMARY NUMBER(16,2), 
	MTD_ASSET NUMBER(16,2)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY HG_HAMC_PUMP_DIR
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE FIELDS TERMINATED BY ',' MISSING FIELD VALUES ARE NULL REJECT ROWS
WITH ALL NULL FIELDS (SCHEME ,PREV_LIMIT ,DEBT_AMC,LUMPSUM,LOAD_EXP,PREV_EXPENSE,PREV_MTD,LIMITS,SUMMARY,MTD_ASSET)     )
      LOCATION
       ( 'LIMIT.CSV'
       )
    );


