--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table UM_ORGANIZATION
--------------------------------------------------------

  CREATE TABLE UM_ORGANIZATION 
   (	ORG_ID NUMBER(8,0), 
	ORG_DESC1 VARCHAR2(4000 BYTE), 
	ORG_DESC2 VARCHAR2(4000 BYTE), 
	ADDRESS_ID NUMBER(8,0), 
	LEVEL_ID NUMBER(12,0), 
	LEVEL_PRED_ID NUMBER(12,0), 
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
 

   COMMENT ON COLUMN UM_ORGANIZATION.FF_N1 IS 'Flexi Field - Number type';
 
   COMMENT ON COLUMN UM_ORGANIZATION.FF_N2 IS 'Flexi Field - Number type';
 
   COMMENT ON COLUMN UM_ORGANIZATION.FF_N3 IS 'Flexi Field - Number type';
 
   COMMENT ON COLUMN UM_ORGANIZATION.FF_VC1 IS 'Flexi Field - Char type';
 
   COMMENT ON COLUMN UM_ORGANIZATION.FF_VC2 IS 'Flexi Field - Char type';
 
   COMMENT ON COLUMN UM_ORGANIZATION.FF_VC3 IS 'Flexi Field - Char type';
 
   COMMENT ON COLUMN UM_ORGANIZATION.FF_VC4 IS 'Flexi Field - Char type';
 
   COMMENT ON COLUMN UM_ORGANIZATION.FF_VC5 IS 'Flexi Field - Char type';
 
   COMMENT ON COLUMN UM_ORGANIZATION.FF_D1 IS 'Flexi Field - Date type';
 
   COMMENT ON COLUMN UM_ORGANIZATION.FF_D2 IS 'Flexi Field - Date type';
 
   COMMENT ON COLUMN UM_ORGANIZATION.FF_D3 IS 'Flexi Field - Date type';
 
   COMMENT ON COLUMN UM_ORGANIZATION.DEACTIVATION_DT IS 'For active records, Hexhibit will stamp the deactivation_Dt with max date (e.g. 31-dec-4099)';
--------------------------------------------------------
--  DDL for Index CT_PK_ORG
--------------------------------------------------------

  CREATE UNIQUE INDEX CT_PK_ORG ON UM_ORGANIZATION (ORG_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE HHINDX_TBS ;
--------------------------------------------------------
--  Constraints for Table UM_ORGANIZATION
--------------------------------------------------------

  ALTER TABLE UM_ORGANIZATION ADD CONSTRAINT CT_CHK_ORG_ACT CHECK (ACTIVE  IN ('Y', 'N')) ENABLE;
 
  ALTER TABLE UM_ORGANIZATION MODIFY (ORG_ID NOT NULL ENABLE);
 
  ALTER TABLE UM_ORGANIZATION MODIFY (ORG_DESC1 NOT NULL ENABLE);
 
  ALTER TABLE UM_ORGANIZATION MODIFY (ADDRESS_ID NOT NULL ENABLE);
 
  ALTER TABLE UM_ORGANIZATION MODIFY (LEVEL_ID NOT NULL ENABLE);
 
  ALTER TABLE UM_ORGANIZATION MODIFY (CR_ID NOT NULL ENABLE);
 
  ALTER TABLE UM_ORGANIZATION MODIFY (CR_DT NOT NULL ENABLE);
 
  ALTER TABLE UM_ORGANIZATION MODIFY (ACTIVE NOT NULL ENABLE);
 
  ALTER TABLE UM_ORGANIZATION MODIFY (ACTIVATION_DT NOT NULL ENABLE);
 
  ALTER TABLE UM_ORGANIZATION MODIFY (DEACTIVATION_DT NOT NULL ENABLE);
