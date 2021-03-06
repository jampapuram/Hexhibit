--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HSYS_JOB_AUDIT
--------------------------------------------------------

  CREATE TABLE HSYS_JOB_AUDIT 
   (	JOB_NAME VARCHAR2(100 BYTE), 
	SOURCE_SYSTEM VARCHAR2(20 BYTE), 
	JOB_START_TIME DATE, 
	JOB_END_TIME DATE, 
	DURATION NUMBER, 
	STATUS NUMBER, 
	JOB_ID NUMBER(12,0), 
	IS_LATEST VARCHAR2(1 BYTE), 
	START_STATUS VARCHAR2(100 BYTE), 
	END_STATUS VARCHAR2(100 BYTE), 
	HI_P_DATE DATE, 
	ACTIVE VARCHAR2(1 BYTE) DEFAULT 'Y', 
	CR_DT DATE DEFAULT SYSDATE, 
	CR_ID VARCHAR2(20 BYTE) DEFAULT 'HAMC_DS'
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE HM_TBS ;
--------------------------------------------------------
--  Constraints for Table HSYS_JOB_AUDIT
--------------------------------------------------------

  ALTER TABLE HSYS_JOB_AUDIT MODIFY (ACTIVE NOT NULL ENABLE);
 
  ALTER TABLE HSYS_JOB_AUDIT MODIFY (CR_DT NOT NULL ENABLE);

