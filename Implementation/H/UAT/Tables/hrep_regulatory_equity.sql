--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HREP_REGULATORY_EQUITY
--------------------------------------------------------

  CREATE TABLE HREP_REGULATORY_EQUITY 
   (	SEBI_STAMPING VARCHAR2(200 BYTE), 
	MCR_ASSET_TYPE VARCHAR2(500 BYTE), 
	MCR_SUB_ASSET_TYPE VARCHAR2(500 BYTE), 
	SECTOR_ALT VARCHAR2(500 BYTE), 
	SCHEMECODE VARCHAR2(200 BYTE), 
	SEBISCHEMECLASS VARCHAR2(500 BYTE), 
	SEBI_SCHEME_CATEGORYY VARCHAR2(500 BYTE), 
	IND1 VARCHAR2(500 BYTE), 
	QUANTIS_DATE DATE, 
	INDUSTRY_NAME VARCHAR2(500 BYTE), 
	SECURITY VARCHAR2(200 BYTE), 
	ISIN_CODE VARCHAR2(200 BYTE), 
	SECURITY_NAME VARCHAR2(500 BYTE), 
	ASSET_NAME VARCHAR2(500 BYTE), 
	SECTOR_CATEGORY VARCHAR2(200 BYTE), 
	ISSUER VARCHAR2(200 BYTE), 
	ISSUER_NAME VARCHAR2(500 BYTE), 
	COUPON_RATE NUMBER(21,8), 
	PORTFOLIO VARCHAR2(200 BYTE), 
	FACE_VALUE NUMBER(21,8), 
	TRANS_DATE DATE, 
	ASSET_CLASS VARCHAR2(200 BYTE), 
	QTY_LOGICAL NUMBER(21,8), 
	ACQU_COST_TCY NUMBER(21,8), 
	NET_CURRENT_ASSETS NUMBER(21,8), 
	NET_ASSET_VALUE NUMBER(21,8), 
	MARKET_VALUE NUMBER(21,8), 
	MATURITY_DATE DATE, 
	PORTFOLIO_CATEGORY_NAME VARCHAR2(500 BYTE), 
	FRONTEND_RATING VARCHAR2(500 BYTE), 
	MATURITY_DAYS NUMBER(21,8), 
	REGULATORY_STAMPING VARCHAR2(200 BYTE), 
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


