--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HREP_GL_DTL_CURR
--------------------------------------------------------

  CREATE TABLE HREP_GL_DTL_CURR 
   (	COMPANY VARCHAR2(200 BYTE), 
	DIVISION VARCHAR2(200 BYTE), 
	PORTFOLIO VARCHAR2(200 BYTE), 
	PORTFOLIO_NAME VARCHAR2(500 BYTE), 
	BS_PL_GROUP VARCHAR2(200 BYTE), 
	ACCOUNT_TYPE VARCHAR2(200 BYTE), 
	ACCOUNT_TYPE_NAME VARCHAR2(500 BYTE), 
	NAV_GROUP VARCHAR2(200 BYTE), 
	NAV_GROUP_NAME VARCHAR2(500 BYTE), 
	SORT_ORDER NUMBER(21,8), 
	ACCOUNT_GROUP VARCHAR2(200 BYTE), 
	ACCOUNT_GROUP_NAME VARCHAR2(500 BYTE), 
	CONTROL_AC VARCHAR2(200 BYTE), 
	CONTROL_AC_NAME VARCHAR2(500 BYTE), 
	GL_ACCOUNT VARCHAR2(200 BYTE), 
	GL_ACCOUNT_NAME VARCHAR2(500 BYTE), 
	CURRENCY VARCHAR2(200 BYTE), 
	PORTFOLIO_CCY VARCHAR2(100 BYTE), 
	TRANS_ID VARCHAR2(100 BYTE), 
	TRANS_DATE DATE, 
	ENTRY_DATE DATE, 
	TRANS_CODE VARCHAR2(200 BYTE), 
	TRANS_REF VARCHAR2(100 BYTE), 
	TRANS_BASE_REF VARCHAR2(100 BYTE), 
	LEVEL_1 VARCHAR2(100 BYTE), 
	LEVEL_2 VARCHAR2(100 BYTE), 
	AMOUNT_TCY NUMBER(21,8), 
	AMOUNT_PCY NUMBER(21,8), 
	SECURITY VARCHAR2(200 BYTE), 
	BROKER VARCHAR2(200 BYTE), 
	COUNTERPARTY VARCHAR2(200 BYTE), 
	MODULE_REF VARCHAR2(100 BYTE), 
	NARRATION VARCHAR2(200 BYTE), 
	BUSINESS_DATE DATE, 
	DATA_SOURCE VARCHAR2(200 BYTE), 
	TIME_STAMP TIMESTAMP (6), 
	FF_N1 NUMBER(21,8), 
	FF_N2 NUMBER(21,8), 
	FF_N3 NUMBER(21,8), 
	FF_N4 NUMBER(21,8), 
	FF_N5 NUMBER(21,8), 
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

