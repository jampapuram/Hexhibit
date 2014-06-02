--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HTMP_NAVDIVIDEND_EXT
--------------------------------------------------------

  CREATE TABLE HTMP_NAVDIVIDEND_EXT 
   (	SCHEME VARCHAR2(500 BYTE), 
	PLAN VARCHAR2(500 BYTE), 
	EX_DIVIDEND_NAV NUMBER(21,5), 
	UPLOAD_DT DATE, 
	VALUE_DATE DATE, 
	STATUS VARCHAR2(1 BYTE)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY HG_HAMC_PUMP_DIR
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE FIELDS TERMINATED BY ',' MISSING FIELD VALUES ARE NULL REJECT ROWS
WITH ALL NULL FIELDS (SCHEME,PLAN,EX_DIVIDEND_NAV,UPLOAD_DT,VALUE_DATE,STATUS)     )
      LOCATION
       ( 'NAVDIVIDEND.CSV'
       )
    );


