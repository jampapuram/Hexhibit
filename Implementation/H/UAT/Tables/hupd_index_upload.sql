--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HUPD_INDEX_UPLOAD
--------------------------------------------------------

  CREATE TABLE HUPD_INDEX_UPLOAD 
   (	INDEX_ID NUMBER(12,0), 
	INDEX_DESCRIPTION VARCHAR2(500 BYTE), 
	INDEX_DATE DATE, 
	INDEX_RATE NUMBER(16,2), 
	UPLOAD_DATE DATE, 
	FF_N1 NUMBER(16,2), 
	FF_N2 NUMBER(16,2), 
	FF_N3 NUMBER(16,2), 
	FF_N4 NUMBER(16,2), 
	FF_N5 NUMBER(16,2), 
	FF_VC1 VARCHAR2(500 BYTE), 
	FF_VC2 VARCHAR2(500 BYTE), 
	FF_VC3 VARCHAR2(500 BYTE), 
	FF_VC4 VARCHAR2(500 BYTE), 
	FF_VC5 VARCHAR2(500 BYTE), 
	FF_D1 DATE, 
	FF_D2 DATE, 
	FF_D3 DATE, 
	FF_D4 DATE, 
	FF_D5 DATE, 
	CR_ID VARCHAR2(50 BYTE), 
	CR_DT TIMESTAMP (6), 
	UPD_ID VARCHAR2(50 BYTE), 
	UPD_DT TIMESTAMP (6), 
	PROCESSED_DT DATE, 
	PROCESSED_STATUS VARCHAR2(2 BYTE), 
	ACTIVE VARCHAR2(2 BYTE), 
	ACTIVATION_DT TIMESTAMP (6), 
	DEACTIVATION_DT TIMESTAMP (6) DEFAULT '31-DEC-4099 12:00:00 AM'
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE HHI_TBS ;

