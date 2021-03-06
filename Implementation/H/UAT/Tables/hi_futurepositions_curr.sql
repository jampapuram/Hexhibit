--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HI_FUTUREPOSITIONS_CURR
--------------------------------------------------------

  CREATE TABLE HI_FUTUREPOSITIONS_CURR 
   (	AMC_CODE VARCHAR2(100 BYTE), 
	SCHEME VARCHAR2(100 BYTE), 
	INVEST_TYPE VARCHAR2(100 BYTE), 
	CUSTODIAN VARCHAR2(100 BYTE), 
	INDXFUTURE VARCHAR2(100 BYTE), 
	UNITS NUMBER(25,5), 
	AVG_PRICE NUMBER(25,5), 
	FCY_PUR_VALUE NUMBER(25,5), 
	PUR_VALUE NUMBER(25,5), 
	FCY_PRFT_LOSS NUMBER(25,5), 
	PRFT_LOSS NUMBER(25,5), 
	FCY_TOT_FEES NUMBER(25,5), 
	TOT_FEES NUMBER(25,5), 
	FCY_VARIABLE_MARGIN NUMBER(25,5), 
	VARIABLE_MARGIN NUMBER(25,5), 
	FCY_MINIMUM_MARGIN NUMBER(25,5), 
	MINIMUM_MARGIN NUMBER(25,5), 
	FCY_INITIAL_MARGIN NUMBER(25,5), 
	INITIAL_MARGIN NUMBER(25,5), 
	FCY_LIABILITY_COST NUMBER(25,5) DEFAULT 0, 
	LIABILITY_COST NUMBER(25,5) DEFAULT 0, 
	FCY_MARKET_VALUE NUMBER(25,5) DEFAULT 0, 
	MARKET_VALUE NUMBER(25,5) DEFAULT 0, 
	FF_N1 NUMBER(25,5), 
	FF_N2 NUMBER(25,5), 
	FF_N3 NUMBER(25,5), 
	FF_N4 NUMBER(25,5), 
	FF_N5 NUMBER(25,5), 
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
  STORAGE(INITIAL 655360 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE HHI_TBS ;
--------------------------------------------------------
--  Constraints for Table HI_FUTUREPOSITIONS_CURR
--------------------------------------------------------

  ALTER TABLE HI_FUTUREPOSITIONS_CURR MODIFY (AMC_CODE NOT NULL ENABLE);
 
  ALTER TABLE HI_FUTUREPOSITIONS_CURR MODIFY (SCHEME NOT NULL ENABLE);
 
  ALTER TABLE HI_FUTUREPOSITIONS_CURR MODIFY (INVEST_TYPE NOT NULL ENABLE);
 
  ALTER TABLE HI_FUTUREPOSITIONS_CURR MODIFY (CUSTODIAN NOT NULL ENABLE);
 
  ALTER TABLE HI_FUTUREPOSITIONS_CURR MODIFY (INDXFUTURE NOT NULL ENABLE);
 
  ALTER TABLE HI_FUTUREPOSITIONS_CURR MODIFY (UNITS NOT NULL ENABLE);
 
  ALTER TABLE HI_FUTUREPOSITIONS_CURR MODIFY (AVG_PRICE NOT NULL ENABLE);
 
  ALTER TABLE HI_FUTUREPOSITIONS_CURR MODIFY (PUR_VALUE NOT NULL ENABLE);
 
  ALTER TABLE HI_FUTUREPOSITIONS_CURR MODIFY (FCY_VARIABLE_MARGIN NOT NULL ENABLE);
 
  ALTER TABLE HI_FUTUREPOSITIONS_CURR MODIFY (MINIMUM_MARGIN NOT NULL ENABLE);
 
  ALTER TABLE HI_FUTUREPOSITIONS_CURR MODIFY (FCY_INITIAL_MARGIN NOT NULL ENABLE);
 
  ALTER TABLE HI_FUTUREPOSITIONS_CURR MODIFY (INITIAL_MARGIN NOT NULL ENABLE);
 
  ALTER TABLE HI_FUTUREPOSITIONS_CURR MODIFY (CR_ID NOT NULL ENABLE);
 
  ALTER TABLE HI_FUTUREPOSITIONS_CURR MODIFY (CR_DT NOT NULL ENABLE);
 
  ALTER TABLE HI_FUTUREPOSITIONS_CURR MODIFY (ACTIVE NOT NULL ENABLE);
 
  ALTER TABLE HI_FUTUREPOSITIONS_CURR MODIFY (ACTIVATION_DT NOT NULL ENABLE);
 
  ALTER TABLE HI_FUTUREPOSITIONS_CURR MODIFY (DEACTIVATION_DT NOT NULL ENABLE);

