--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HTMP_MCY_EXT
--------------------------------------------------------

  CREATE TABLE HTMP_MCY_EXT 
   (	MCY_DATE DATE, 
	FANDO VARCHAR2(500 BYTE), 
	P VARCHAR2(500 BYTE), 
	CM_CODE VARCHAR2(500 BYTE), 
	MKT_TYPE VARCHAR2(500 BYTE), 
	CP_CODE VARCHAR2(500 BYTE), 
	ACC_TYPE VARCHAR2(500 BYTE), 
	CLIENT_ACC_CODE NUMBER(21,5), 
	INSTR_TYPE VARCHAR2(500 BYTE), 
	SYMBOL VARCHAR2(500 BYTE), 
	EXPIRY DATE, 
	STRIKE_PRICE NUMBER(21,5), 
	OPTION_TYPE VARCHAR2(500 BYTE), 
	CA_LEVEL NUMBER(21,5), 
	BF_LONG_QTY NUMBER(21,5), 
	BF_LONG_VALUE NUMBER(21,5), 
	BF_SHORT_QTY NUMBER(21,5), 
	BF_SHORT_VALUE NUMBER(21,5), 
	OP_PUR_QTY NUMBER(21,5), 
	OP_PUR_VALUE NUMBER(21,5), 
	OP_SALE_QTY NUMBER(21,5), 
	OP_SALE_VALUE NUMBER(21,5), 
	PRE_LONG_QTY_BEF_EXERCISE NUMBER(21,5), 
	PRE_LONG_VAL_BEF_EXERCISE NUMBER(21,5), 
	PRE_SHORT_QTY_BEF_ASS NUMBER(21,5), 
	PRE_SHORT_VAL_BEF_ASS NUMBER(21,5), 
	EXE_QTY NUMBER(21,5), 
	ASS_QTY NUMBER(21,5), 
	POST_LONG_QTY_BEF_EXE NUMBER(21,5), 
	POST_LONG_VAL_BEF_EXE NUMBER(21,5), 
	POST_SHORT_QTY_BEF_ASS NUMBER(21,5), 
	POST_SHORT_VAL_BEF_ASS NUMBER(21,5), 
	SETTL_PRICE NUMBER(21,5), 
	NET_PRM NUMBER(21,5), 
	MTM NUMBER(21,5), 
	FINAL_SETLL NUMBER(21,5), 
	EXERCISE_VALUE NUMBER(21,5)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY HG_HAMC_PUMP_DIR
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE FIELDS TERMINATED BY ',' MISSING FIELD VALUES ARE NULL REJECT ROWS
WITH ALL NULL FIELDS (MCY_DATE,FANDO,P,CM_CODE,MKT_TYPE,CP_CODE,ACC_TYPE,CLIENT_ACC_CODE,INSTR_TYPE,SYMBOL,EXPIRY,STRIKE_PRICE,OPTION_TYPE,CA_LEVEL,BF_LONG_QTY,BF_LONG_VALUE,BF_SHORT_QTY,BF_SHORT_VALUE,OP_PUR_QTY,OP_PUR_VALUE,OP_SALE_QTY,OP_SALE_VALUE,PRE_LONG_QTY_BEF_EXERCISE,PRE_LONG_VAL_BEF_EXERCISE,PRE_SHORT_QTY_BEF_ASS,PRE_SHORT_VAL_BEF_ASS,EXE_QTY,ASS_QTY,POST_LONG_QTY_BEF_EXE,POST_LONG_VAL_BEF_EXE,POST_SHORT_QTY_BEF_ASS,POST_SHORT_VAL_BEF_ASS,SETTL_PRICE,NET_PRM,MTM,FINAL_SETLL,EXERCISE_VALUE)     )
      LOCATION
       ( 'MCY.CSV'
       )
    );


