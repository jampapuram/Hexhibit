--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HREP_REPO_TXN_PREV
--------------------------------------------------------

  CREATE TABLE HREP_REPO_TXN_PREV 
   (	MODULE_REF VARCHAR2(100 BYTE), 
	COMPANY VARCHAR2(100 BYTE), 
	DIVISION VARCHAR2(100 BYTE), 
	PORTFOLIO VARCHAR2(100 BYTE), 
	PORTFOLIO_NAME VARCHAR2(500 BYTE), 
	PORTFOLIO_CATEGORY VARCHAR2(100 BYTE), 
	PORTFOLIO_CATEGORY_NAME VARCHAR2(100 BYTE), 
	PORTFOLIO_CCY VARCHAR2(100 BYTE), 
	ASSET_GROUP VARCHAR2(100 BYTE), 
	ASSET_GROUP_NAME VARCHAR2(500 BYTE), 
	ASSET_CLASS VARCHAR2(100 BYTE), 
	ASSET_NAME VARCHAR2(500 BYTE), 
	TRANS_ID VARCHAR2(100 BYTE), 
	TRANS_DATE DATE, 
	CURRENCY VARCHAR2(100 BYTE), 
	TRANS_CODE VARCHAR2(100 BYTE), 
	TRANS_NAME VARCHAR2(500 BYTE), 
	INFLOW_OUTFLOW VARCHAR2(1 BYTE), 
	MATURITY_DATE DATE, 
	NOOF_DAYS NUMBER(5,0), 
	COUPON_RATE NUMBER(21,5), 
	NET_AMOUNT_TCY NUMBER(21,5), 
	NET_AMOUNT_PCY NUMBER(21,5), 
	TOT_INTEREST_TCY NUMBER(21,5), 
	TOT_INTEREST_PCY NUMBER(21,5), 
	ACCR_INT_TCY NUMBER(21,5), 
	ACCR_INT_PCY NUMBER(21,5), 
	MATURITY_AMT_TCY NUMBER(21,5), 
	MATURITY_AMT_PCY NUMBER(21,5), 
	MATURITY_REFERENCE VARCHAR2(100 BYTE), 
	NET_ASSET_VALUE NUMBER(21,5), 
	PER_NAV NUMBER(21,5), 
	ENTRY_DATE DATE, 
	TRANS_REF VARCHAR2(100 BYTE), 
	TRANS_BASE_REF VARCHAR2(100 BYTE), 
	TRANS_SRL_NO NUMBER(5,0), 
	COUNTERPARTY VARCHAR2(100 BYTE), 
	COUNTERPARTY_NAME VARCHAR2(500 BYTE), 
	CPARTY_GROUP VARCHAR2(100 BYTE), 
	CPARTY_GROUP_NAME VARCHAR2(100 BYTE), 
	IS_CPARTY_RELATED VARCHAR2(1 BYTE), 
	IS_MATURED VARCHAR2(1 BYTE), 
	MATURITY_DAYS NUMBER(5,0), 
	IS_SYSGEN VARCHAR2(1 BYTE), 
	REMARKS VARCHAR2(500 BYTE), 
	BUSINESS_DATE DATE, 
	DESC1 VARCHAR2(500 BYTE), 
	DESC2 VARCHAR2(500 BYTE), 
	DESC3 VARCHAR2(500 BYTE), 
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
	CR_ID VARCHAR2(50 BYTE) DEFAULT 'HAMC', 
	CR_DT TIMESTAMP (6) DEFAULT SYSTIMESTAMP, 
	UPD_ID VARCHAR2(50 BYTE), 
	UPD_DT TIMESTAMP (6), 
	ACTIVE VARCHAR2(2 BYTE) DEFAULT 'Y', 
	ACTIVATION_DT TIMESTAMP (6) DEFAULT SYSTIMESTAMP, 
	DEACTIVATION_DT TIMESTAMP (6) DEFAULT '31-DEC-4099 12:00:00 AM'
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE HHI_TBS ;
--------------------------------------------------------
--  Constraints for Table HREP_REPO_TXN_PREV
--------------------------------------------------------

  ALTER TABLE HREP_REPO_TXN_PREV MODIFY (CR_ID NOT NULL ENABLE);
 
  ALTER TABLE HREP_REPO_TXN_PREV MODIFY (CR_DT NOT NULL ENABLE);
 
  ALTER TABLE HREP_REPO_TXN_PREV MODIFY (ACTIVE NOT NULL ENABLE);
 
  ALTER TABLE HREP_REPO_TXN_PREV MODIFY (ACTIVATION_DT NOT NULL ENABLE);
 
  ALTER TABLE HREP_REPO_TXN_PREV MODIFY (DEACTIVATION_DT NOT NULL ENABLE);

