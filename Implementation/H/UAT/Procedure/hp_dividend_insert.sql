--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure HP_DIVIDEND_INSERT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE HP_DIVIDEND_INSERT 
AS
BEGIN
  INSERT
  INTO HI_DIVIDEND
    (
      DIVIDEND_ID ,
    NAV_WKEND_DT ,
    NAV_SCHEME           ,
    NAV_SCHEMECLASS      ,
    NAV_SCHCLASS_NAME    ,
    NAV_NET_ASSET_AMOUNT ,
    NAV_UNITS            ,
    NAV                  ,
    PREV_NAV_UNITS       ,
    UNIT_MOVEMENT        ,
    UNREAL_AMOUNT        ,
    PREV_UNREAL_AMOUNT   ,
    CAMCODE_DIFF         ,
    CLOSING_BALANCE      ,
    CORPORATE_UNITS      ,
    CORPORATE_NET_ASSETS ,
    CORP_DD_DR           ,
    CORP_DD_TAX_DR       ,
    INDIVIDUAL_UNITS     ,
    INDIVIDUAL_NET_ASSETS,
    INDV_DD_DR           ,
    INDV_DD_TAX_DR       ,
    CORP_LESS_DD         ,
    INDIVIDUAL_LESS_DD   ,
    EX_DIVIDEND_NAV      ,
    PU_DIVIDEND_NAV      
    )
  SELECT DIV_SEQ.NEXTVAL ,
   NAV_WKEND_DT ,
    NAV_SCHEME           ,
    NAV_SCHEMECLASS      ,
    NAV_SCHCLASS_NAME    ,
    NAV_NET_ASSET_AMOUNT ,
    NAV_UNITS            ,
    NAV                  ,
    PREV_NAV_UNITS       ,
    UNIT_MOVEMENT        ,
    UNREAL_AMOUNT        ,
    PREV_UNREAL_AMOUNT   ,
    CAMCODE_DIFF         ,
    CLOSING_BALANCE      ,
    CORPORATE_UNITS      ,
    CORPORATE_NET_ASSETS ,
    CORP_DD_DR           ,
    CORP_DD_TAX_DR       ,
    INDIVIDUAL_UNITS     ,
    INDIVIDUAL_NET_ASSETS,
    INDV_DD_DR           ,
    INDV_DD_TAX_DR       ,
    CORP_LESS_DD         ,
    INDIVIDUAL_LESS_DD   ,
    EX_DIVIDEND_NAV      ,
    PU_DIVIDEND_NAV      
  FROM HV_DIVIDEND_COMPUTAION;
END;

/
