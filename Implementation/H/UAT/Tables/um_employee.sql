--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table UM_EMPLOYEE
--------------------------------------------------------

  CREATE TABLE UM_EMPLOYEE 
   (	ORG_ID NUMBER(8,0), 
	EMPLOYEE_ID NUMBER(8,0), 
	SRC_SYS_ID NUMBER(8,0), 
	EMP_CODE VARCHAR2(50 BYTE), 
	EMP_NAME VARCHAR2(4000 BYTE), 
	EMP_NAME2 VARCHAR2(4000 BYTE), 
	LEVEL_ID NUMBER(12,0), 
	LEVEL_PRED_ID NUMBER(12,0), 
	EMP_TYPE VARCHAR2(50 BYTE), 
	RELATIONSHIP_SINCE DATE, 
	RELATIONSHIP_ENDED VARCHAR2(4000 BYTE), 
	ROLE VARCHAR2(500 BYTE), 
	DESIGNATION VARCHAR2(500 BYTE), 
	DEPARTMENT_ID VARCHAR2(50 BYTE), 
	BASE_CURRENCY_CODE VARCHAR2(50 BYTE), 
	GROSS_CURRENCY_CODE VARCHAR2(50 BYTE), 
	GROSS_YEARLY_SAL NUMBER(12,0), 
	EMP_EMAIL_ID1 VARCHAR2(50 BYTE), 
	EMP_EMAIL_ID2 VARCHAR2(50 BYTE), 
	EMP_MOBILE_NO1 NUMBER(16,0), 
	EMP_MOBILE_NO2 NUMBER(16,0), 
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
--------------------------------------------------------
--  DDL for Index CT_PK_UE
--------------------------------------------------------

  CREATE UNIQUE INDEX CT_PK_UE ON UM_EMPLOYEE (EMPLOYEE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE HHINDX_TBS ;
--------------------------------------------------------
--  Constraints for Table UM_EMPLOYEE
--------------------------------------------------------

  ALTER TABLE UM_EMPLOYEE ADD CONSTRAINT ACTIVE_UE_CHK CHECK (ACTIVE IN ('Y', 'N')) ENABLE;
 
  ALTER TABLE UM_EMPLOYEE MODIFY (ORG_ID NOT NULL ENABLE);
 
  ALTER TABLE UM_EMPLOYEE MODIFY (EMPLOYEE_ID NOT NULL ENABLE);
 
  ALTER TABLE UM_EMPLOYEE MODIFY (SRC_SYS_ID NOT NULL ENABLE);
 
  ALTER TABLE UM_EMPLOYEE MODIFY (EMP_CODE NOT NULL ENABLE);
 
  ALTER TABLE UM_EMPLOYEE MODIFY (EMP_NAME NOT NULL ENABLE);
 
  ALTER TABLE UM_EMPLOYEE MODIFY (LEVEL_ID NOT NULL ENABLE);
 
  ALTER TABLE UM_EMPLOYEE MODIFY (ROLE NOT NULL ENABLE);
 
  ALTER TABLE UM_EMPLOYEE MODIFY (CR_ID NOT NULL ENABLE);
 
  ALTER TABLE UM_EMPLOYEE MODIFY (CR_DT NOT NULL ENABLE);
 
  ALTER TABLE UM_EMPLOYEE MODIFY (ACTIVE NOT NULL ENABLE);
 
  ALTER TABLE UM_EMPLOYEE MODIFY (ACTIVATION_DT NOT NULL ENABLE);
 
  ALTER TABLE UM_EMPLOYEE MODIFY (DEACTIVATION_DT NOT NULL ENABLE);
