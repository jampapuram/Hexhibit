--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HI_OPTIONSDEAL_PREV
--------------------------------------------------------

  CREATE TABLE HI_OPTIONSDEAL_PREV 
   (	AMC_CODE VARCHAR2(100 BYTE), 
	DEAL_ID VARCHAR2(100 BYTE), 
	RECTYPE VARCHAR2(1 BYTE), 
	CURRNO NUMBER(5,0), 
	SCHEME VARCHAR2(100 BYTE), 
	TRADE_DATE DATE, 
	VALUE_DATE DATE, 
	BOOK_DATE DATE, 
	TRAN_TYPE VARCHAR2(100 BYTE), 
	ASSET_TYPE VARCHAR2(100 BYTE), 
	OPTION_SECURITY VARCHAR2(100 BYTE), 
	OPTION_TYPE VARCHAR2(1 BYTE), 
	UNITS NUMBER(21,5), 
	STK_EXCH VARCHAR2(3 BYTE), 
	SEGMENT VARCHAR2(3 BYTE), 
	CURRENCY VARCHAR2(3 BYTE), 
	EXCH_RATE NUMBER(21,10) DEFAULT 0, 
	INVEST_TYPE VARCHAR2(100 BYTE), 
	CUSTODIAN VARCHAR2(100 BYTE), 
	CUSTODIAN_N VARCHAR2(12 BYTE), 
	BROKER VARCHAR2(100 BYTE), 
	CPARTY_ID VARCHAR2(100 BYTE), 
	BASE_SECURITY VARCHAR2(100 BYTE), 
	CONTRACT_CODE VARCHAR2(100 BYTE), 
	CALL_PUT VARCHAR2(1 BYTE), 
	EXPIRY_DATE DATE, 
	OPTION_PREMIUM NUMBER(21,8), 
	BROKERAGE NUMBER(21,5), 
	FCY_BRK_COMMN NUMBER(21,5), 
	BRK_COMMN NUMBER(21,5), 
	FCY_SERVICE_TAX NUMBER(21,5), 
	SERVICE_TAX NUMBER(21,5), 
	FCY_CLEARING_FEE NUMBER(21,5), 
	CLEARING_FEE NUMBER(21,5), 
	FCY_SETTLEMENT_FEE NUMBER(21,5), 
	SETTLEMENT_FEE NUMBER(21,5), 
	FCY_TRANSACTION_LEVY NUMBER(21,5), 
	TRANSACTION_LEVY NUMBER(21,5), 
	NETT_VAL NUMBER(21,5), 
	FCY_NETT_VAL NUMBER(21,5), 
	COVERED_CALL_YN VARCHAR2(1 BYTE), 
	ACCOUNT VARCHAR2(100 BYTE), 
	GROSS_VAL NUMBER(21,5), 
	FCY_GROSS_VAL NUMBER(21,5), 
	APP_REFER VARCHAR2(100 BYTE), 
	MKT_PRICE NUMBER(21,6), 
	STRIKE_PRICE NUMBER(21,6), 
	PRFT_LOSS NUMBER(21,5), 
	FCY_PRFT_LOSS NUMBER(21,5), 
	FCY_OPTION_ACQU_COST NUMBER(21,5), 
	OPTION_ACQU_COST NUMBER(21,5), 
	FCY_OPTION_ACQU_COST_N NUMBER(21,5), 
	OPTION_ACQU_COST_N NUMBER(21,5), 
	UNITS_N NUMBER(21,5), 
	BROKER_REF VARCHAR2(100 BYTE), 
	TARIFF_CCY VARCHAR2(100 BYTE), 
	TARIFF_EXCH_RATE NUMBER(21,10) DEFAULT 0, 
	CUSTCHRG NUMBER(21,5), 
	FCY_CUSTCHRG NUMBER(21,5), 
	CUST_REFER VARCHAR2(100 BYTE), 
	UNDERLYING_CODE VARCHAR2(100 BYTE), 
	SETTLEMENT_MODE VARCHAR2(1 BYTE), 
	ACQU_COST NUMBER(21,5) DEFAULT 0, 
	FCY_ACQU_COST NUMBER(21,5) DEFAULT 0, 
	TRANS_COST NUMBER(21,5) DEFAULT 0, 
	ADV_FEE_CURRENCY VARCHAR2(100 BYTE), 
	FCY_ADV_FEE NUMBER(21,5) DEFAULT 0, 
	ADV_FEE NUMBER(21,5) DEFAULT 0, 
	ADV_FEE_TRADE NUMBER(21,5) DEFAULT 0, 
	ADV_FEE_EXCH_RATE NUMBER(21,10) DEFAULT 0, 
	SPL_FEE_CURRENCY VARCHAR2(50 BYTE), 
	FCY_SPL_FEE NUMBER(21,5) DEFAULT 0, 
	SPL_FEE NUMBER(21,5) DEFAULT 0, 
	SPL_FEE_TRADE NUMBER(21,5) DEFAULT 0, 
	SPL_FEE_EXCH_RATE NUMBER(21,10) DEFAULT 0, 
	UNITS_UTILISED NUMBER(21,5) DEFAULT 0, 
	SELF_UTILISED NUMBER(21,5) DEFAULT 0, 
	FCY_OPTION_ACQUCOST_UTIL NUMBER(21,5) DEFAULT 0, 
	OPTION_ACQUCOST_UTIL NUMBER(21,5) DEFAULT 0, 
	FCY_TOT_FEES NUMBER(21,5) DEFAULT 0, 
	TOT_FEES NUMBER(21,5) DEFAULT 0, 
	FCY_FEES_SELF_UTIL NUMBER(21,5) DEFAULT 0, 
	FEES_SELF_UTIL NUMBER(21,5) DEFAULT 0, 
	FCY_FEES_COST NUMBER(21,5) DEFAULT 0, 
	FEES_COST NUMBER(21,5) DEFAULT 0, 
	REMARKS VARCHAR2(100 BYTE), 
	LST_ENTRY NUMBER(5,0), 
	STATUS VARCHAR2(2 BYTE), 
	INP_DT_TM VARCHAR2(50 BYTE), 
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
--  DDL for Index CT_HI_ODEALS_PREV
--------------------------------------------------------

  CREATE UNIQUE INDEX CT_HI_ODEALS_PREV ON HI_OPTIONSDEAL_PREV (AMC_CODE, DEAL_ID, RECTYPE, CURRNO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE HHI_TBS ;
--------------------------------------------------------
--  Constraints for Table HI_OPTIONSDEAL_PREV
--------------------------------------------------------

  ALTER TABLE HI_OPTIONSDEAL_PREV MODIFY (AMC_CODE NOT NULL ENABLE);
 
  ALTER TABLE HI_OPTIONSDEAL_PREV MODIFY (DEAL_ID NOT NULL ENABLE);
 
  ALTER TABLE HI_OPTIONSDEAL_PREV MODIFY (RECTYPE NOT NULL ENABLE);
 
  ALTER TABLE HI_OPTIONSDEAL_PREV MODIFY (CURRNO NOT NULL ENABLE);
 
  ALTER TABLE HI_OPTIONSDEAL_PREV MODIFY (SCHEME NOT NULL ENABLE);
 
  ALTER TABLE HI_OPTIONSDEAL_PREV MODIFY (TRADE_DATE NOT NULL ENABLE);
 
  ALTER TABLE HI_OPTIONSDEAL_PREV MODIFY (VALUE_DATE NOT NULL ENABLE);
 
  ALTER TABLE HI_OPTIONSDEAL_PREV MODIFY (BOOK_DATE NOT NULL ENABLE);
 
  ALTER TABLE HI_OPTIONSDEAL_PREV MODIFY (TRAN_TYPE NOT NULL ENABLE);
 
  ALTER TABLE HI_OPTIONSDEAL_PREV MODIFY (OPTION_SECURITY NOT NULL ENABLE);
 
  ALTER TABLE HI_OPTIONSDEAL_PREV MODIFY (OPTION_TYPE NOT NULL ENABLE);
 
  ALTER TABLE HI_OPTIONSDEAL_PREV MODIFY (STK_EXCH NOT NULL ENABLE);
 
  ALTER TABLE HI_OPTIONSDEAL_PREV MODIFY (CURRENCY NOT NULL ENABLE);
 
  ALTER TABLE HI_OPTIONSDEAL_PREV MODIFY (INVEST_TYPE NOT NULL ENABLE);
 
  ALTER TABLE HI_OPTIONSDEAL_PREV MODIFY (CUSTODIAN NOT NULL ENABLE);
 
  ALTER TABLE HI_OPTIONSDEAL_PREV MODIFY (CALL_PUT NOT NULL ENABLE);
 
  ALTER TABLE HI_OPTIONSDEAL_PREV MODIFY (EXPIRY_DATE NOT NULL ENABLE);
 
  ALTER TABLE HI_OPTIONSDEAL_PREV MODIFY (COVERED_CALL_YN NOT NULL ENABLE);
