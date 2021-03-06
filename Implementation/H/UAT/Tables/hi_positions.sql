--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HI_POSITIONS
--------------------------------------------------------

  CREATE TABLE HI_POSITIONS 
   (	AMC_CODE VARCHAR2(100 BYTE), 
	SCHEME VARCHAR2(100 BYTE), 
	INVEST_TYPE VARCHAR2(100 BYTE), 
	CUSTODIAN VARCHAR2(100 BYTE), 
	SECURITY VARCHAR2(100 BYTE), 
	UNREL_AMT NUMBER(18,3) DEFAULT 0, 
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
  TABLESPACE HHI_TBS ;
--------------------------------------------------------
--  DDL for Index CT_UK_HPOS
--------------------------------------------------------

  CREATE UNIQUE INDEX CT_UK_HPOS ON HI_POSITIONS (SCHEME, SECURITY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE HHINDX_TBS ;
--------------------------------------------------------
--  Constraints for Table HI_POSITIONS
--------------------------------------------------------

  ALTER TABLE HI_POSITIONS MODIFY (CR_ID NOT NULL ENABLE);
 
  ALTER TABLE HI_POSITIONS MODIFY (CR_DT NOT NULL ENABLE);
 
  ALTER TABLE HI_POSITIONS MODIFY (ACTIVE NOT NULL ENABLE);
 
  ALTER TABLE HI_POSITIONS MODIFY (ACTIVATION_DT NOT NULL ENABLE);
 
  ALTER TABLE HI_POSITIONS MODIFY (DEACTIVATION_DT NOT NULL ENABLE);

