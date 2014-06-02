--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HI_REPO_TXNS_PREV
--------------------------------------------------------

  CREATE TABLE HI_REPO_TXNS_PREV 
   (	AMC_CODE VARCHAR2(100 BYTE), 
	DEAL_ID VARCHAR2(100 BYTE), 
	SRL_NO NUMBER(3,0), 
	RECTYPE VARCHAR2(1 BYTE), 
	CURRNO NUMBER(5,0), 
	CURRENCY VARCHAR2(100 BYTE), 
	EXCH_RATE NUMBER(21,10), 
	SCHEME VARCHAR2(100 BYTE), 
	CUSTODIAN VARCHAR2(100 BYTE), 
	SECURITY VARCHAR2(100 BYTE), 
	APP_REFER VARCHAR2(100 BYTE), 
	VALUE_DATE DATE, 
	FCY_AMOUNT NUMBER(21,5), 
	AMOUNT NUMBER(21,5), 
	ACCOUNT VARCHAR2(100 BYTE), 
	INSTR_TYPE VARCHAR2(1 BYTE) DEFAULT 'C', 
	CHQ_NUMBER VARCHAR2(100 BYTE), 
	FCY_INT_RECBLE NUMBER(21,5), 
	INT_RECBLE NUMBER(21,5), 
	FCY_ACCR_INT NUMBER(21,5), 
	ACCR_INT NUMBER(21,5), 
	FCY_INT_AMT NUMBER(21,5), 
	INT_AMT NUMBER(21,5), 
	REMARKS VARCHAR2(500 BYTE), 
	SYSGEN_Y_N VARCHAR2(1 BYTE), 
	CPARTY_ID VARCHAR2(100 BYTE), 
	TERM NUMBER(5,0), 
	INTEREST NUMBER(21,5), 
	TDS_INTRST NUMBER(21,5), 
	MAT_DATE DATE, 
	ZONE VARCHAR2(100 BYTE), 
	CHQ_DATE DATE, 
	AMOUNT_ORG NUMBER(21,5) DEFAULT 0, 
	AMOUNT_VAL NUMBER(21,5) DEFAULT 0, 
	ACCR_INT_REVAL NUMBER(21,5) DEFAULT 0, 
	AMOUNT_REVAL NUMBER(21,5) DEFAULT 0, 
	TRAN_TYPE VARCHAR2(100 BYTE), 
	TRAN_TYPE_GS VARCHAR2(100 BYTE), 
	LST_ENTRY NUMBER(5,0), 
	LST_ENTRY_GS NUMBER(5,0), 
	ACCENT_DEAL_ID VARCHAR2(100 BYTE), 
	ACCENT_DEAL_ID_GS VARCHAR2(100 BYTE), 
	STATUS VARCHAR2(4 BYTE), 
	INP_DT_TM VARCHAR2(16 BYTE), 
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
  TABLESPACE HHI_TBS ;
--------------------------------------------------------
--  DDL for Index CT_UK_HIREPO_TXNS_PREV
--------------------------------------------------------

  CREATE UNIQUE INDEX CT_UK_HIREPO_TXNS_PREV ON HI_REPO_TXNS_PREV (AMC_CODE, APP_REFER, DEAL_ID, SCHEME, CURRENCY, VALUE_DATE, RECTYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE HHINDX_TBS ;
--------------------------------------------------------
--  Constraints for Table HI_REPO_TXNS_PREV
--------------------------------------------------------

  ALTER TABLE HI_REPO_TXNS_PREV MODIFY (CR_ID NOT NULL ENABLE);
 
  ALTER TABLE HI_REPO_TXNS_PREV MODIFY (CR_DT NOT NULL ENABLE);
 
  ALTER TABLE HI_REPO_TXNS_PREV MODIFY (ACTIVE NOT NULL ENABLE);
 
  ALTER TABLE HI_REPO_TXNS_PREV MODIFY (ACTIVATION_DT NOT NULL ENABLE);
 
  ALTER TABLE HI_REPO_TXNS_PREV MODIFY (DEACTIVATION_DT NOT NULL ENABLE);

