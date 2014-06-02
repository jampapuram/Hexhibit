--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HTMP_NAVMISSED_EXT
--------------------------------------------------------

  CREATE TABLE HTMP_NAVMISSED_EXT 
   (	SCHEME VARCHAR2(500 BYTE), 
	PLAN VARCHAR2(500 BYTE), 
	MISSED_VALUE NUMBER(21,5), 
	INPUT_DATE DATE, 
	UPLOAD_DT DATE
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY HG_HAMC_PUMP_DIR
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE FIELDS TERMINATED BY ',' MISSING FIELD VALUES ARE NULL REJECT ROWS
WITH ALL NULL FIELDS (SCHEME,PLAN,MISSED_VALUE,INPUT_DATE,UPLOAD_DT)     )
      LOCATION
       ( 'NAVMISSED.CSV'
       )
    );


