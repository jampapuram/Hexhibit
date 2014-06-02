--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HTMP_PROVISION_EXT
--------------------------------------------------------

  CREATE TABLE HTMP_PROVISION_EXT 
   (	SCHEME VARCHAR2(50 BYTE), 
	SCHEME_CATEGORY VARCHAR2(500 BYTE), 
	SCHEME_GROUP VARCHAR2(500 BYTE), 
	AMOUNT NUMBER(21,5), 
	VALUE_DATE DATE, 
	UPD_DT DATE
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY HG_HAMC_PUMP_DIR
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE FIELDS TERMINATED BY ',' MISSING FIELD VALUES ARE NULL REJECT ROWS
WITH ALL NULL FIELDS (SCHEME ,SCHEME_CATEGORY ,SCHEME_GROUP,AMOUNT,VALUE_DATE,UPD_DT)     )
      LOCATION
       ( 'PROVISION.CSV'
       )
    );


