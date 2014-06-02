--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HI_LASTNAV_PREV
--------------------------------------------------------

  CREATE TABLE HI_LASTNAV_PREV 
   (	AMC_CODE VARCHAR2(100 BYTE), 
	SCHEME VARCHAR2(100 BYTE), 
	INTERNAL_SCHEME VARCHAR2(100 BYTE), 
	NAV_DATE DATE, 
	NAV_METHOD VARCHAR2(100 BYTE), 
	SCHCLASS VARCHAR2(100 BYTE), 
	SECURITY VARCHAR2(100 BYTE), 
	INVEST_TYPE VARCHAR2(100 BYTE), 
	ACCOUNT VARCHAR2(100 BYTE), 
	UNITS NUMBER(21,5), 
	AVG_PRICE NUMBER(21,5), 
	MKT_PRICE NUMBER(21,5), 
	AMOUNT NUMBER(28,2), 
	FCY_AMOUNT NUMBER(28,2), 
	NAV_TYPE VARCHAR2(100 BYTE), 
	ASSET_TYPE VARCHAR2(100 BYTE), 
	CUSTODIAN VARCHAR2(100 BYTE), 
	CONTROL_AC VARCHAR2(100 BYTE), 
	NAME VARCHAR2(500 BYTE), 
	CURRENCY VARCHAR2(100 BYTE), 
	EXCH_RATE NUMBER(21,10), 
	PUR_VALUE NUMBER(21,5), 
	FCY_PUR_VALUE NUMBER(21,5), 
	GAIN_LOSS NUMBER(21,5), 
	FCY_GAIN_LOSS NUMBER(21,5), 
	BOOK_COST NUMBER(21,5), 
	FCY_BOOK_COST NUMBER(21,5), 
	ACCR_INT NUMBER(21,5), 
	FCY_ACCR_INT NUMBER(21,5), 
	ACCR_AOD NUMBER(21,5), 
	FCY_ACCR_AOD NUMBER(21,5), 
	FCY_INT_RECBLE NUMBER(21,5), 
	INT_RECBLE NUMBER(21,5), 
	INJ_COST NUMBER(21,5), 
	FCY_INJ_COST NUMBER(21,5), 
	LISTED_YN VARCHAR2(3 BYTE), 
	MULTI_COEFF NUMBER(21,5), 
	YTM NUMBER(16,8), 
	PUR_VALUE_REVAL NUMBER(21,5), 
	ACCR_INT_REVAL NUMBER(21,5), 
	PREMDISC_AMT_REVAL NUMBER(21,5), 
	FCY_UNREL_AMT NUMBER(21,5), 
	UNREL_AMT NUMBER(21,5), 
	VALUATION_TYPE VARCHAR2(100 BYTE), 
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


