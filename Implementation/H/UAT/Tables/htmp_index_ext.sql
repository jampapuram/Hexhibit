--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HTMP_INDEX_EXT
--------------------------------------------------------

  CREATE TABLE HTMP_INDEX_EXT 
   (	INDEX_DESCRIPTION VARCHAR2(500 BYTE), 
	INDEX_DATE DATE, 
	INDEX_RATE NUMBER(21,5), 
	UPLOAD_DATE DATE
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY HG_HAMC_PUMP_DIR
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE FIELDS TERMINATED BY ',' MISSING FIELD VALUES ARE NULL REJECT ROWS
WITH ALL NULL FIELDS (INDEX_DESCRIPTION,INDEX_DATE,INDEX_RATE,UPLOAD_DATE)     )
      LOCATION
       ( 'INDEX.CSV'
       )
    );


