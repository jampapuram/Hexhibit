--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HREP_NAVCONTROL_LIVE_CURR
--------------------------------------------------------

  CREATE TABLE HREP_NAVCONTROL_LIVE_CURR 
   (	PORTFOLIO VARCHAR2(100 BYTE), 
	PORTFOLIO_NAME VARCHAR2(500 BYTE), 
	PORTFOLIO_CLASS_NAME VARCHAR2(500 BYTE), 
	PORTFOLIO_TYPE VARCHAR2(100 BYTE), 
	PORTFOLIO_CATEGORY VARCHAR2(500 BYTE), 
	PORTFOLIO_CATEGORY_ALT VARCHAR2(500 BYTE), 
	PORTFOLIO_CATEGORY_NAME_ALT VARCHAR2(500 BYTE), 
	PER_MGMT_RECUR_EXP NUMBER(21,8), 
	DIVIDEND NUMBER(21,8), 
	MISSED_VALUE NUMBER(21,8), 
	SCHCLASS VARCHAR2(100 BYTE), 
	SCHEME_AUM_CR NUMBER(21,8), 
	SCHEME_UNITS_CR NUMBER(21,8), 
	AUM_CR NUMBER(21,8), 
	UNITS_CR NUMBER(21,8), 
	NAV NUMBER(21,8), 
	LAST_NAV NUMBER(21,8), 
	TOTAL_EXPENSE NUMBER(21,8), 
	PLANWISE_INCOME NUMBER(21,8), 
	MGMT_RECURRING_EXPENSE NUMBER(21,8), 
	NET_ADDITION_PLANWISE NUMBER(21,8), 
	NAV_MOV NUMBER(21,8), 
	MANUAL_CURRENT_DAY_NAV NUMBER(21,8), 
	WEEKNAV_SCHEME VARCHAR2(100 BYTE), 
	WEEKEND_DT DATE, 
	NAV_DATE DATE, 
	TOTAL_INCOME NUMBER, 
	BUY_NAV_VALUE NUMBER(21,8), 
	SELL_NAV_VALUE NUMBER(21,8), 
	FINAL_MANUAL_CURRENT_DAY_NAV NUMBER(21,8), 
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
	CR_ID VARCHAR2(50 BYTE) DEFAULT 'AMC', 
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


