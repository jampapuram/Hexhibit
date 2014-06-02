--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HI_WEEKNAV_CURR
--------------------------------------------------------

  CREATE TABLE HI_WEEKNAV_CURR 
   (	AMC_CODE VARCHAR2(100 BYTE), 
	SCHEME VARCHAR2(100 BYTE), 
	INTERNAL_SCHEME VARCHAR2(100 BYTE), 
	SCHCLASS VARCHAR2(100 BYTE), 
	WEEKEND_DT DATE, 
	NET_ASSETS NUMBER(18,3), 
	MGMT_FEES NUMBER(14,3), 
	TRUST_FEES NUMBER(14,3), 
	ACC_FEES NUMBER(14,3), 
	OTHER_FEES NUMBER(14,3), 
	NET_ASSETS_F NUMBER(18,3), 
	OTH1_FEES NUMBER(14,3) DEFAULT 0, 
	OTH2_FEES NUMBER(14,3) DEFAULT 0, 
	RATIO NUMBER(14,12), 
	UNITS_OUTS NUMBER(20,4), 
	UNITS_OUTSAMC NUMBER(20,4), 
	UNITS_OUTSOMF NUMBER(20,4), 
	APPRE_DEPRE NUMBER(18,3), 
	PRFT_LOSS NUMBER(18,3), 
	NAV_METHOD VARCHAR2(100 BYTE), 
	INCOME NUMBER(18,3) DEFAULT 0, 
	EXPENSE NUMBER(18,3) DEFAULT 0, 
	MARKET_LOSS NUMBER(18,3) DEFAULT 0, 
	NAV_MOVEMENT NUMBER(18,3), 
	LAST_NET_ASSETS NUMBER(18,3), 
	LAST_UNITS_OUTS NUMBER(20,4), 
	LAST_NAV NUMBER(24,8), 
	TWRR NUMBER(20,4), 
	NAV NUMBER(20,4), 
	REMARKS VARCHAR2(100 BYTE), 
	MGR_CHRGS NUMBER(20,4), 
	SELLPRICE NUMBER(24,8), 
	BUYPRICE NUMBER(24,8), 
	UNDISTRIBUT_INC NUMBER(18,3), 
	UNDISTRIBUT_DIV_INC NUMBER(18,3), 
	UNDISTRIBUTED_DIV_INCOME NUMBER(18,3), 
	PERF_FEES NUMBER(14,3), 
	PFEE_DAY_YN VARCHAR2(100 BYTE), 
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
--------------------------------------------------------
--  Constraints for Table HI_WEEKNAV_CURR
--------------------------------------------------------

  ALTER TABLE HI_WEEKNAV_CURR MODIFY (AMC_CODE NOT NULL ENABLE);
 
  ALTER TABLE HI_WEEKNAV_CURR MODIFY (SCHCLASS NOT NULL ENABLE);
 
  ALTER TABLE HI_WEEKNAV_CURR MODIFY (WEEKEND_DT NOT NULL ENABLE);

