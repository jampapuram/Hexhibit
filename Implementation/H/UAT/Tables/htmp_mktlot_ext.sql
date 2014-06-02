--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HTMP_MKTLOT_EXT
--------------------------------------------------------

  CREATE TABLE HTMP_MKTLOT_EXT 
   (	SECURITY VARCHAR2(500 BYTE), 
	MKTLOT NUMBER(16,2), 
	MKTLOT_DATE DATE
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY HG_HAMC_PUMP_DIR
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE FIELDS TERMINATED BY ',' MISSING FIELD VALUES ARE NULL REJECT ROWS
WITH ALL NULL FIELDS (SECURITY,MKTLOT,MKTLOT_DATE)     )
      LOCATION
       ( 'MKTLOT.CSV'
       )
    );


