--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HTMP_NSE_EXT
--------------------------------------------------------

  CREATE TABLE HTMP_NSE_EXT 
   (	SYMBOL VARCHAR2(100 BYTE), 
	SERIES VARCHAR2(100 BYTE), 
	OPEN NUMBER(21,5), 
	HIGH NUMBER(21,5), 
	LOW NUMBER(21,5), 
	CLOSE NUMBER(21,5), 
	LAST NUMBER(21,5), 
	PREVCLOSE NUMBER(21,5), 
	TOTTRDQTY NUMBER(21,5), 
	TOTTRDVAL NUMBER(21,5), 
	NSE_DATE DATE, 
	TOTALTRADES NUMBER(8,0), 
	ISIN VARCHAR2(100 BYTE)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY HG_HAMC_PUMP_DIR
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE FIELDS TERMINATED BY ',' MISSING FIELD VALUES ARE NULL REJECT ROWS
WITH ALL NULL FIELDS (SYMBOL,SERIES,OPEN,HIGH,LOW,CLOSE,LAST,PREVCLOSE,TOTTRDQTY,TOTTRDVAL,NSE_DATE,TOTALTRADES,ISIN)     )
      LOCATION
       ( 'NSE.csv'
       )
    )
  PARALLEL ;


