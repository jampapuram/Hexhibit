--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HI_TOTAL_MTM_DEAL
--------------------------------------------------------

  CREATE TABLE HI_TOTAL_MTM_DEAL 
   (	TOTAL_MTM_DEAL_ID NUMBER(16,2), 
	NSE_CODE VARCHAR2(500 BYTE), 
	SCHEME VARCHAR2(500 BYTE), 
	INDXFUTURE VARCHAR2(500 BYTE), 
	UNITS NUMBER(21,8), 
	AVG_PRICE NUMBER(21,8), 
	MARKET_VALUE NUMBER(21,8), 
	LIABILITY_COST NUMBER(21,8), 
	MTM_PRICE NUMBER(21,8), 
	EXPIRY_DATE DATE, 
	CODE_EXPIRY VARCHAR2(500 BYTE), 
	SCH_INDX VARCHAR2(500 BYTE), 
	MAT_DATE DATE, 
	MKT_PRICE NUMBER(21,8), 
	VALUE_DATE DATE, 
	MTM_PREV NUMBER(21,8), 
	SECURITY VARCHAR2(500 BYTE), 
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
	CR_ID VARCHAR2(50 BYTE) DEFAULT 'ADMIN', 
	CR_DT TIMESTAMP (6) DEFAULT SYSTIMESTAMP, 
	UPD_ID VARCHAR2(50 BYTE), 
	UPD_DT TIMESTAMP (6), 
	PROCESSED_DT DATE, 
	PROCESSED_STATUS VARCHAR2(2 BYTE) DEFAULT 'U', 
	ACTIVE VARCHAR2(2 BYTE) DEFAULT 'Y', 
	ACTIVATION_DT TIMESTAMP (6) DEFAULT SYSTIMESTAMP, 
	DEACTIVATION_DT TIMESTAMP (6) DEFAULT '31-DEC-4099 12:00:00 AM'
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE HHI_TBS ;


