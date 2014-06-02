--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HTMP_MKTPRICE_EXT
--------------------------------------------------------

  CREATE TABLE HTMP_MKTPRICE_EXT 
   (	MKTPRICE_DATE DATE, 
	INSTRUMENT VARCHAR2(500 BYTE), 
	UNDERLYING_CODE VARCHAR2(500 BYTE), 
	EXPIRY_DATE DATE, 
	MKTPRICE NUMBER(21,5)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY HG_HAMC_PUMP_DIR
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE FIELDS TERMINATED BY ',' MISSING FIELD VALUES ARE NULL REJECT ROWS
WITH ALL NULL FIELDS (MKTPRICE_DATE,INSTRUMENT,UNDERLYING_CODE,EXPIRY_DATE,MKTPRICE)     )
      LOCATION
       ( 'MKTPRICE.csv'
       )
    )
  PARALLEL ;


