--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HM_SCHEME
--------------------------------------------------------

  CREATE TABLE HM_SCHEME 
   (	AMC_CODE VARCHAR2(100 BYTE), 
	SCHEME VARCHAR2(100 BYTE), 
	SCHEME_NAME VARCHAR2(500 BYTE), 
	SCHEME_TYPE VARCHAR2(100 BYTE), 
	SALE_LOAD NUMBER(21,5), 
	PUR_LOAD NUMBER(21,5), 
	DISTRIBUTABLE_INC_ACCT VARCHAR2(100 BYTE), 
	PRFT_LOSS_ACCT VARCHAR2(100 BYTE), 
	UNIT_RESERVE VARCHAR2(100 BYTE), 
	UNIT_CAPAC VARCHAR2(100 BYTE), 
	RECTYPE VARCHAR2(1 BYTE), 
	CURRNO NUMBER(5,0), 
	SCH_NUMBER VARCHAR2(100 BYTE), 
	UNITS NUMBER(20,4), 
	FACE_VALUE NUMBER(18,3), 
	CAPITAL NUMBER(18,3), 
	ISSUE_VAL NUMBER(14,4), 
	PURCH_VAL NUMBER(14,4), 
	NAV NUMBER(18,3), 
	START_DATE DATE, 
	END_DATE DATE, 
	PREV_DATE DATE, 
	CUR_DATE DATE, 
	NEXT_DATE DATE, 
	PRV_NAV_DT DATE, 
	NXT_NAV_DT DATE, 
	ACTIVATE_Y_N VARCHAR2(1 BYTE) DEFAULT 'Y', 
	PORT_TYPE VARCHAR2(100 BYTE), 
	CURRENCY VARCHAR2(3 BYTE), 
	RELATED_Y_N VARCHAR2(1 BYTE) DEFAULT 'N', 
	PRV_YREND DATE, 
	STATUS VARCHAR2(4 BYTE), 
	INP_DT_TM VARCHAR2(16 BYTE), 
	DESC1 VARCHAR2(500 BYTE), 
	DESC2 VARCHAR2(500 BYTE), 
	DESC3 VARCHAR2(500 BYTE), 
	FF_N1 NUMBER(16,2), 
	FF_N2 NUMBER(16,2), 
	FF_N3 NUMBER(16,2), 
	FF_VC1 VARCHAR2(500 BYTE), 
	FF_VC2 VARCHAR2(500 BYTE), 
	FF_VC3 VARCHAR2(500 BYTE), 
	FF_VC4 VARCHAR2(500 BYTE), 
	FF_VC5 VARCHAR2(500 BYTE), 
	FF_D1 DATE, 
	FF_D2 DATE, 
	FF_D3 DATE, 
	CR_ID VARCHAR2(50 BYTE), 
	CR_DT TIMESTAMP (6) DEFAULT SYSTIMESTAMP, 
	UPD_ID VARCHAR2(50 BYTE), 
	UPD_DT TIMESTAMP (6), 
	ACTIVE VARCHAR2(2 BYTE) DEFAULT 'Y', 
	ACTIVATION_DT TIMESTAMP (6) DEFAULT SYSTIMESTAMP, 
	DEACTIVATION_DT TIMESTAMP (6) DEFAULT '31-DEC-4099 12:00:00 AM'
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 57344 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE HM_TBS ;
 

   COMMENT ON COLUMN HM_SCHEME.FF_N1 IS 'LOAD';
 
   COMMENT ON COLUMN HM_SCHEME.FF_N2 IS 'TER';
 
   COMMENT ON COLUMN HM_SCHEME.FF_N3 IS 'MGMT FEES';
--------------------------------------------------------
--  DDL for Index CT_UK_HSCH
--------------------------------------------------------

  CREATE UNIQUE INDEX CT_UK_HSCH ON HM_SCHEME (SCHEME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE HHINDX_TBS ;
--------------------------------------------------------
--  Constraints for Table HM_SCHEME
--------------------------------------------------------

  ALTER TABLE HM_SCHEME MODIFY (AMC_CODE NOT NULL ENABLE);
 
  ALTER TABLE HM_SCHEME MODIFY (SCHEME NOT NULL ENABLE);
 
  ALTER TABLE HM_SCHEME MODIFY (RECTYPE NOT NULL ENABLE);
 
  ALTER TABLE HM_SCHEME MODIFY (CURRNO NOT NULL ENABLE);
 
  ALTER TABLE HM_SCHEME MODIFY (INP_DT_TM NOT NULL ENABLE);
 
  ALTER TABLE HM_SCHEME MODIFY (CR_ID NOT NULL ENABLE);
 
  ALTER TABLE HM_SCHEME MODIFY (CR_DT NOT NULL ENABLE);
 
  ALTER TABLE HM_SCHEME MODIFY (ACTIVE NOT NULL ENABLE);
 
  ALTER TABLE HM_SCHEME MODIFY (ACTIVATION_DT NOT NULL ENABLE);
 
  ALTER TABLE HM_SCHEME MODIFY (DEACTIVATION_DT NOT NULL ENABLE);

