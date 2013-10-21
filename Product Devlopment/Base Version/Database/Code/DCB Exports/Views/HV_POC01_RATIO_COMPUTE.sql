--------------------------------------------------------
--  File created - Friday-October-18-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View HV_POC01_RATIO_COMPUTE
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "RIGEL"."HV_POC01_RATIO_COMPUTE" ("WEEK_OF_YEAR", "MONTH_LONG", "MONTH_LONG_DESC", "QUARTER_ID", "HALF_OF_YEAR_ID", "YEAR_ID", "ORG_ID", "TXN_DT", "MONTHLY_POS", "PREVIOUS_MONTH_POS_AMT", "GROWTH_RATIO", "CURRENT_POS", "POS_COUNT", "TOTAL_INTEREST_OS_BASE_AMOUNT", "NPA_POS_AMOUNT", "PROVISION_PERCENTAGE", "PROVISION_AMOUNT", "COVERAGE_RATIO", "COVERAGE_COUNT", "SLIPPAGE_AMOUNT", "UPGRADE_AMOUNT", "NORMAL_RECOVERY_AMOUNT", "UNC_AMOUNT", "UNS_AMOUNT", "SCHEME_CODE", "AMOUNT_APPROVED", "PRODUCT_CODE", "PRODUCT_DESC1", "PRORGAM", "PROMOTION", "SOURCE_OFFICE_ID", "GEO_ID", "BUSINESS_LINE", "BUSINESS_SUBLINE", "PRODUCT", "FACILITY", "AGE_BRACKET", "NET_INCOME_BRACKET", "AGENCY_NAME1", "AGENCY_TYPE_DESC1", "CIBIL_SCORE", "LTV_DESC1", "DBR_DESC1", "RM_NAME", "PROPERTY_TPE", "BOUNCE_MONTH", "BOUNCE_COUNT", "PRESENTATION_COUNT", "BOUNCE_RATIO", "FORE_POS", "PREV_FORE_POS", "MATURITY_POS", "PREV_MATURITY_POS", "ROI", "PORTFOLIO_RATE", "SOURCING_ROI", "SOURCING_BOOKED_AMT", "BOOKED_AMT", "BOOKED_COUNT") AS 
  SELECT TIME1.WEEK_OF_YEAR,
    TIME1.MONTH_LONG,
    TIME1.MONTH_LONG_DESC,
    TIME1.QUARTER_ID,
    TIME1.HALF_OF_YEAR_ID,
    TIME1.YEAR_ID,
    HAS.ORG_ID,
    HAS.TXN_DT TXN_DT,
    HAS.TOTAL_PRIN_OS_BASE_AMOUNT MONTHLY_POS,
    DECODE(HAS.TXN_DT ,
    (SELECT MIN(HAS1.TXN_DT)
    FROM HI_ACCOUNT_SNAPSHOT HAS1
    WHERE HAS1.ACCOUNT_ID = HAS.ACCOUNT_ID
    ), 0, NVL(LAG((HAS.TOTAL_PRIN_OS_BASE_AMOUNT),1) OVER (ORDER BY HAS.ACCOUNT_ID,HAS.TXN_DT),0)) PREVIOUS_MONTH_POS_AMT,
    /* TPC.POS MONTHLY_POS,
    TPC.PREVIOUS_MONTH_POS_AMT PREVIOUS_MONTH_POS_AMT,*/
    NULL Growth_Ratio,
    DECODE(TO_CHAR(HAS.TXN_DT,'DD-MM-YY'),TO_CHAR(
    (SELECT MIN(HAS1.TXN_DT)
    FROM HI_ACCOUNT_SNAPSHOT HAS1
    WHERE HAS1.ACCOUNT_ID = HAS.ACCOUNT_ID
    ),'DD-MM-YY'),HAS.TOTAL_PRIN_OS_BASE_AMOUNT, 0) CURRENT_POS,
    TO_NUMBER(1) POS_COUNT,
    has.TOTAL_INTEREST_OS_BASE_AMOUNT,
    (
    CASE
      WHEN NVL(HAS.PROVISION_PERC,0) > 0
      THEN (HAS.TOTAL_PRIN_OS_BASE_AMOUNT)/10000000
      ELSE TO_NUMBER(0)
    END) NPA_POS_AMOUNT,
    HAS.PROVISION_PERC PROVISION_PERCENTAGE,
    NVL(HAS.PROVISIONS_BASE_AMOUNT,0) /10000000 PROVISION_AMOUNT,
    (
    CASE
      WHEN NVL(HAS.PROVISION_PERC,0) > 0
      THEN (NVL(HAS.PROVISIONS_BASE_AMOUNT,0)/DECODE (NVL(HAS.TOTAL_PRIN_OS_BASE_AMOUNT,0),0,1,NVL(HAS.TOTAL_PRIN_OS_BASE_AMOUNT,1)))* 100
      ELSE TO_NUMBER(0)
    END)COVERAGE_RATIO,
    (
    CASE
      WHEN NVL(HAS.PROVISION_PERC,0) > 0
      THEN (to_number(1))
      ELSE TO_NUMBER(0)
    END) COVERAGE_COUNT,
    DECODE( HAS.FF_VC1, 'SLIPPAGE', HAS.FF_N1, TO_NUMBER(0))                           /100000 SLIPPAGE_AMOUNT,
    DECODE( HAS.FF_VC1, 'UPGRADE', HAS.FF_N1, TO_NUMBER(0))                            /100000 UPGRADE_AMOUNT,
    DECODE( HAS.FF_VC1, 'NORMAL RECOVERY', HAS.FF_N1, TO_NUMBER(0))                    /100000 NORMAL_RECOVERY_AMOUNT,
    DECODE( NVL(HAS.FF_VC2,0), 'UPGRADE AND CLOSED', NVL(HAS.FF_N1,0) , TO_NUMBER(0))  /100000 UNC_AMOUNT,
    DECODE( NVL(HAS.FF_VC2,0), 'UPGRADE AND STANDARD', NVL(HAS.FF_N1,0) , TO_NUMBER(0))/100000 UNS_AMOUNT,
    -- HAS.APPLICATION_NO,
    --HAS.ACCOUNT_ID,
    HAF.SCHEME_CODE,
    HAF.AMOUNT_APPROVED,
    HAF.PRODUCT_CODE,
    HAF.PRODUCT_DESC1,
    HAF.FF_VC4 PRORGAM,
    HAF.FF_VC5 PROMOTION,
    --HAS.ACTIVE,
    HAD.SOURCE_OFFICE_ID,
    BRANCH.GEO_ID,
    HOD.HOD_PRODUCT_DESC1 BUSINESS_LINE,
    HOD.HOD_SUBPRODUCT_DESC1 BUSINESS_SUBLINE,
    HOD.HOD_FACILITY_DESC1 PRODUCT,--FACILITY,
    HOD.HOD_SCHEME_DESC1 FACILITY,
    HD.AGE_BRACKET_DESC1 AGE_BRACKET,
    HD.INCOME_BRACKET_DESC1 NET_INCOME_BRACKET,
    AGENCY.AGENCY_NAME1,
    AGENCY. AGENCY_TYPE_DESC1,
    HD.SCORECARD_DESC1 CIBIL_SCORE,
    HD.LTV_DESC1,
    HD.DBR_DESC1 ,
    HAC. EMPLOYEE_NAME1 RM_NAME,
    HAF.FF_VC1 PROPERTY_TPE,
    NULL BOUNCE_MONTH,
    NULL BOUNCE_COUNT,
    NULL PRESENTATION_COUNT,
    NULL BOUNCE_RATIO,
    NULL FORE_POS,
    NULL PREV_FORE_POS,
    NULL MATURITY_POS,
    NULL PREV_MATURITY_POS,
    HAS.FF_N3 ROI,
    --nvl((HAS.FF_N3*TPC.POS),0) Portfolio_Rate,
    NVL((HAS.FF_N3*HAS.TOTAL_PRIN_OS_BASE_AMOUNT),0) Portfolio_Rate,
    0 SOURCING_ROI,
    0 SOURCING_BOOKED_AMT,
    0 BOOKED_AMT,
    0 BOOKED_COUNT
  FROM HI_APPLICATION_FACILITIES HAF,
    -- temp_pos_compute TPC,
    TIME_CAL_DIM TIME1,
    HI_APPLICATION_DEMOGRAPHICS HAD,
    HI_ACCOUNT_SNAPSHOT HAS,
    UM_GEOGRAPHY BRANCH,
    HI_APPLICATION_AGENCY HAC,
    UM_AGENCY AGENCY,
    HDM_OFFERING_DIM HOD,
    HDM_CUSTOMER HD--,
    -- HI_FACILITIES_DTLS HFD
  WHERE BRANCH.GEO_CODE = TO_CHAR(HAD.SOURCE_OFFICE_ID)
    --- AND HAS.ACCOUNT_ID=tpc.account_id
  AND HAS.APPLICATION_NO = HAC.APPLICATION_NO
  AND HAF.APPLICATION_NO = HAD.APPLICATION_NO
  AND TIME1.DAY_ID (+)   = HAS.TXN_DT
  AND TIME1.ORG_ID (+)   = HAS.ORG_ID
  AND AGENCY.AGENCY_CODE = HAC.AGENCY_CODE
    -- AND HD.UID_NO (+)      = HAS.ACCOUNT_ID
  AND HD.UID_NO = HAS.APPLICATION_NO
    -- AND HFD.ACCOUNT_ID = HAF.ACCOUNT_ID
  AND HAF.ORG_ID       =777
  AND HAF.ACCOUNT_ID   = HAS.ACCOUNT_ID
  AND HAF.PRODUCT_CODE = HOD.HOD_SCHEME_CODE
  AND HAS.ACCOUNT_ID   = HAF.ACCOUNT_ID
  AND HAS.ORG_ID       =777
--AND HAS.ACCOUNT_ID in ('1053537') ---------------------------------
  UNION ALL
  --TO COMPUTE BOUNCE RATE
  SELECT TIME1.WEEK_OF_YEAR,
    TIME1.MONTH_LONG,
    TIME1.MONTH_LONG_DESC,
    TIME1.QUARTER_ID,
    TIME1.HALF_OF_YEAR_ID,
    TIME1.YEAR_ID,
    HAS.ORG_ID,
    HAS.TXN_DT TXN_DT,
    NULL MONTHLY_POS,
    NULL PREVIOUS_MONTH_POS_AMT,
    NULL Growth_Ratio,
    NULL CURRENT_POS,
    TO_NUMBER(0) POS_COUNT,
    NULL TOTAL_INTEREST_OS_BASE_AMOUNT,
    NULL NPA_POS_AMOUNT,
    NULL PROVISION_PERCENTAGE,
    NULL PROVISION_AMOUNT,
    NULL COVERAGE_RATIO,
    NULL COVERAGE_COUNT,
    NULL SLIPPAGE_AMOUNT,
    NULL UPGRADE_AMOUNT,
    NULL NORMAL_RECOVERY_AMOUNT,
    NULL UNC_AMOUNT,
    NULL UNS_AMOUNT,
    -- HAS.APPLICATION_NO,
    --HAS.ACCOUNT_ID,
    HAF.SCHEME_CODE,
    NULL AMOUNT_APPROVED,
    HAF.PRODUCT_CODE,
    HAF.PRODUCT_DESC1,
    HAF.FF_VC4 PRORGAM,
    HAF.FF_VC5 PROMOTION,
    --HAS.ACTIVE,
    HAD.SOURCE_OFFICE_ID,
    BRANCH.GEO_ID,
    HOD.HOD_PRODUCT_DESC1 BUSINESS_LINE,
    HOD.HOD_SUBPRODUCT_DESC1 BUSINESS_SUBLINE,
    HOD.HOD_FACILITY_DESC1 PRODUCT,--FACILITY,
    HOD.HOD_SCHEME_DESC1 FACILITY,
    HD.AGE_BRACKET_DESC1 AGE_BRACKET,
    HD.INCOME_BRACKET_DESC1 NET_INCOME_BRACKET,
    AGENCY.AGENCY_NAME1,
    AGENCY. AGENCY_TYPE_DESC1,
    HD.SCORECARD_DESC1 CIBIL_SCORE,
    HD.LTV_DESC1,
    HD.DBR_DESC1 ,
    HAC. EMPLOYEE_NAME1 RM_NAME,
    HAF.FF_VC1 PROPERTY_TPE,
    -- HBP.ACCOUNT_ID,
    --HBP.TXN_DT,
    HBP.BOUNCE_MONTH BOUNCE_MONTH,
    HBP.BOUNCE_COUNT BOUNCE_COUNT,
    HBP.PRESENTATION_COUNT PRESENTATION_COUNT,
    (HBP.BOUNCE_COUNT/HBP.PRESENTATION_COUNT) BOUNCE_RATIO,
    NULL FORE_POS,
    NULL PREV_FORE_POS,
    NULL MATURITY_POS,
    NULL PREV_MATURITY_POS,
    NULL ROI,
    NULL Portfolio_Rate,
0 SOURCING_ROI,
    0 SOURCING_BOOKED_AMT,
    0 BOOKED_AMT,
    0 BOOKED_COUNT
  FROM HI_APPLICATION_FACILITIES HAF,
    TIME_CAL_DIM TIME1,
    HI_APPLICATION_DEMOGRAPHICS HAD,
    HI_ACCOUNT_SNAPSHOT HAS,
    HV_BOUNCE_PRESENTATION HBP,
    UM_GEOGRAPHY BRANCH,
    HI_APPLICATION_AGENCY HAC,
    UM_AGENCY AGENCY,
    HDM_OFFERING_DIM HOD,
    HDM_CUSTOMER HD
  WHERE BRANCH.GEO_CODE  = TO_CHAR(HAD.SOURCE_OFFICE_ID)
  AND HBP.ACCOUNT_ID     = HAS.ACCOUNT_ID
  AND HAS.APPLICATION_NO = HAC.APPLICATION_NO
  AND HAF.APPLICATION_NO = HAD.APPLICATION_NO
  AND TIME1.DAY_ID (+)   = HBP.TXN_DT
  AND TIME1.ORG_ID       = HAS.ORG_ID
  AND AGENCY.AGENCY_CODE = HAC.AGENCY_CODE
    -- AND HD.UID_NO (+)      = HBP.ACCOUNT_ID
  AND HD.UID_NO        = HBP.APPLICATION_NO
  AND HAF.ORG_ID       =HAS.ORG_ID
  AND HAF.ACCOUNT_ID   = HBP.ACCOUNT_ID
  AND HAF.PRODUCT_CODE = HOD.HOD_SCHEME_CODE
  AND HAS.ACCOUNT_ID   = HBP.ACCOUNT_ID
  AND HAS.ORG_ID       =777
--AND HAS.ACCOUNT_ID in ('1053537') --------------------------------------------
  UNION ALL
  --TO COMPUTE FORECLOSURE RATE
  SELECT TIME1.WEEK_OF_YEAR,
    TIME1.MONTH_LONG,
    TIME1.MONTH_LONG_DESC,
    TIME1.QUARTER_ID,
    TIME1.HALF_OF_YEAR_ID,
    TIME1.YEAR_ID,
    HAS.ORG_ID,
    HAS.TXN_DT TXN_DT,
    NULL MONTHLY_POS,
    NULL PREVIOUS_MONTH_POS_AMT,
    NULL Growth_Ratio,
    NULL CURRENT_POS,
    TO_NUMBER(0) POS_COUNT,
    NULL TOTAL_INTEREST_OS_BASE_AMOUNT,
    NULL NPA_POS_AMOUNT,
    NULL PROVISION_PERCENTAGE,
    NULL PROVISION_AMOUNT,
    NULL COVERAGE_RATIO,
    NULL COVERAGE_COUNT,
    NULL SLIPPAGE_AMOUNT,
    NULL UPGRADE_AMOUNT,
    NULL NORMAL_RECOVERY_AMOUNT,
    NULL UNC_AMOUNT,
    NULL UNS_AMOUNT,
    -- HAS.APPLICATION_NO,
    --HAS.ACCOUNT_ID,
    HAF.SCHEME_CODE,
    NULL AMOUNT_APPROVED,
    HAF.PRODUCT_CODE,
    HAF.PRODUCT_DESC1,
    HAF.FF_VC4 PRORGAM,
    HAF.FF_VC5 PROMOTION,
    --HAS.ACTIVE,
    HAD.SOURCE_OFFICE_ID,
    BRANCH.GEO_ID,
    HOD.HOD_PRODUCT_DESC1 BUSINESS_LINE,
    HOD.HOD_SUBPRODUCT_DESC1 BUSINESS_SUBLINE,
    HOD.HOD_FACILITY_DESC1 PRODUCT,--FACILITY,
    HOD.HOD_SCHEME_DESC1 FACILITY,
    HD.AGE_BRACKET_DESC1 AGE_BRACKET,
    HD.INCOME_BRACKET_DESC1 NET_INCOME_BRACKET,
    AGENCY.AGENCY_NAME1,
    AGENCY. AGENCY_TYPE_DESC1,
    HD.SCORECARD_DESC1 CIBIL_SCORE,
    HD.LTV_DESC1,
    HD.DBR_DESC1 ,
    HAC. EMPLOYEE_NAME1 RM_NAME,
    HAF.FF_VC1 PROPERTY_TPE,
    -- HBP.ACCOUNT_ID,
    --HBP.TXN_DT,
    NULL BOUNCE_MONTH,
    NULL BOUNCE_COUNT,
    NULL PRESENTATION_COUNT,
    NULL BOUNCE_RATIO,
    --HFR.ACCOUNT_ID
    --HFR.MONTHS FORE_MONTH,
    HFR.POS FORE_POS,
    HFR.PREVIOUS_MONTH_FORCLOSURE_AMT PREV_FORE_POS,
    NULL MATURITY_POS,
    NULL PREV_MATURITY_POS,
    NULL ROI,
    NULL Portfolio_Rate,
0 SOURCING_ROI,
    0 SOURCING_BOOKED_AMT,
    0 BOOKED_AMT,
    0 BOOKED_COUNT
  FROM HI_APPLICATION_FACILITIES HAF,
    TIME_CAL_DIM TIME1,
    HI_APPLICATION_DEMOGRAPHICS HAD,
    HI_ACCOUNT_SNAPSHOT HAS,
    HV_FORCLOSURE_RATE HFR,
    UM_GEOGRAPHY BRANCH,
    HI_APPLICATION_AGENCY HAC,
    UM_AGENCY AGENCY,
    HDM_OFFERING_DIM HOD,
    HDM_CUSTOMER HD
  WHERE BRANCH.GEO_CODE  = TO_CHAR(HAD.SOURCE_OFFICE_ID)
  AND HFR.ACCOUNT_ID     = HAS.ACCOUNT_ID
  AND HAS.APPLICATION_NO = HAC.APPLICATION_NO
  AND HAF.APPLICATION_NO = HAD.APPLICATION_NO
  AND TIME1.DAY_ID (+)   = HFR.TXN_DT
  AND TIME1.ORG_ID       = HAS.ORG_ID
  AND AGENCY.AGENCY_CODE = HAC.AGENCY_CODE
  AND HD.UID_NO          = HFR.APPLICATION_NO
  AND HAF.ORG_ID         =HAS.ORG_ID
  AND HAF.ACCOUNT_ID     = HFR.ACCOUNT_ID
  AND HAF.PRODUCT_CODE   = HOD.HOD_SCHEME_CODE
  AND HAS.ACCOUNT_ID     = HFR.ACCOUNT_ID
  AND HAS.ORG_ID         =777
--AND HAS.ACCOUNT_ID in ('1053537') -----------------------------------
  UNION ALL
  --TO COMPUTE MATURITY RATE
  SELECT TIME1.WEEK_OF_YEAR,
    TIME1.MONTH_LONG,
    TIME1.MONTH_LONG_DESC,
    TIME1.QUARTER_ID,
    TIME1.HALF_OF_YEAR_ID,
    TIME1.YEAR_ID,
    HAS.ORG_ID,
    HAS.TXN_DT TXN_DT,
    NULL MONTHLY_POS,
    NULL PREVIOUS_MONTH_POS_AMT,
    NULL Growth_Ratio,
    NULL CURRENT_POS,
    TO_NUMBER(0) POS_COUNT,
    NULL TOTAL_INTEREST_OS_BASE_AMOUNT,
    NULL NPA_POS_AMOUNT,
    NULL PROVISION_PERCENTAGE,
    NULL PROVISION_AMOUNT,
    NULL COVERAGE_RATIO,
    NULL COVERAGE_COUNT,
    NULL SLIPPAGE_AMOUNT,
    NULL UPGRADE_AMOUNT,
    NULL NORMAL_RECOVERY_AMOUNT,
    NULL UNC_AMOUNT,
    NULL UNS_AMOUNT,
    -- HAS.APPLICATION_NO,
    --HAS.ACCOUNT_ID,
    HAF.SCHEME_CODE,
    NULL AMOUNT_APPROVED,
    HAF.PRODUCT_CODE,
    HAF.PRODUCT_DESC1,
    HAF.FF_VC4 PRORGAM,
    HAF.FF_VC5 PROMOTION,
    --HAS.ACTIVE,
    HAD.SOURCE_OFFICE_ID,
    BRANCH.GEO_ID,
    HOD.HOD_PRODUCT_DESC1 BUSINESS_LINE,
    HOD.HOD_SUBPRODUCT_DESC1 BUSINESS_SUBLINE,
    HOD.HOD_FACILITY_DESC1 PRODUCT,--FACILITY,
    HOD.HOD_SCHEME_DESC1 FACILITY,
    HD.AGE_BRACKET_DESC1 AGE_BRACKET,
    HD.INCOME_BRACKET_DESC1 NET_INCOME_BRACKET,
    AGENCY.AGENCY_NAME1,
    AGENCY. AGENCY_TYPE_DESC1,
    HD.SCORECARD_DESC1 CIBIL_SCORE,
    HD.LTV_DESC1,
    HD.DBR_DESC1 ,
    HAC. EMPLOYEE_NAME1 RM_NAME,
    HAF.FF_VC1 PROPERTY_TPE,
    -- HBP.ACCOUNT_ID,
    --HBP.TXN_DT,
    NULL BOUNCE_MONTH,
    NULL BOUNCE_COUNT,
    NULL PRESENTATION_COUNT,
    NULL BOUNCE_RATIO,
    --HFR.ACCOUNT_ID
    --HFR.MONTHS FORE_MONTH,
    NULL FORE_POS,
    NULL PREV_FORE_POS,
    HMR.POS MATURITY_POS,
    HMR.PREVIOUS_MONTH_FORCLOSURE_AMT PREV_MATURITY_POS,
    NULL ROI,
    NULL Portfolio_Rate,
0 SOURCING_ROI,
    0 SOURCING_BOOKED_AMT,
    0 BOOKED_AMT,
    0 BOOKED_COUNT
  FROM HI_APPLICATION_FACILITIES HAF,
    TIME_CAL_DIM TIME1,
    HI_APPLICATION_DEMOGRAPHICS HAD,
    HI_ACCOUNT_SNAPSHOT HAS,
    hv_maturity_rate HMR,
    UM_GEOGRAPHY BRANCH,
    HI_APPLICATION_AGENCY HAC,
    UM_AGENCY AGENCY,
    HDM_OFFERING_DIM HOD,
    HDM_CUSTOMER HD
  WHERE BRANCH.GEO_CODE  = TO_CHAR(HAD.SOURCE_OFFICE_ID)
  AND HMR.ACCOUNT_ID     = HAS.ACCOUNT_ID
  AND HAS.APPLICATION_NO = HAC.APPLICATION_NO
  AND HAF.APPLICATION_NO = HAD.APPLICATION_NO
  AND TIME1.DAY_ID (+)   = HMR.TXN_DT
  AND TIME1.ORG_ID       = HAS.ORG_ID
  AND AGENCY.AGENCY_CODE = HAC.AGENCY_CODE
  AND HD.UID_NO          = HMR.APPLICATION_NO
  AND HAF.ORG_ID         =HAS.ORG_ID
  AND HAF.ACCOUNT_ID     = HMR.ACCOUNT_ID
  AND HAF.PRODUCT_CODE   = HOD.HOD_SCHEME_CODE
  AND HAS.ACCOUNT_ID     = HMR.ACCOUNT_ID
  AND HAS.ORG_ID         =777
--AND HAS.ACCOUNT_ID in ('1053537') --------------------------------------------------------
  UNION ALL
  ---to compute booked amount, count and SOURCING ROI
  SELECT TIME1.WEEK_OF_YEAR,
    TIME1.MONTH_LONG,
    TIME1.MONTH_LONG_DESC,
    TIME1.QUARTER_ID,
    TIME1.HALF_OF_YEAR_ID,
    TIME1.YEAR_ID,
    HAT.ORG_ID,
    HAT.TXN_DT TXN_DT,
    NULL MONTHLY_POS,
    NULL PREVIOUS_MONTH_POS_AMT,
    NULL Growth_Ratio,
    NULL CURRENT_POS,
    TO_NUMBER(0) POS_COUNT,
    NULL TOTAL_INTEREST_OS_BASE_AMOUNT,
    NULL NPA_POS_AMOUNT,
    NULL PROVISION_PERCENTAGE,
    NULL PROVISION_AMOUNT,
    NULL COVERAGE_RATIO,
    NULL COVERAGE_COUNT,
    NULL SLIPPAGE_AMOUNT,
    NULL UPGRADE_AMOUNT,
    NULL NORMAL_RECOVERY_AMOUNT,
    NULL UNC_AMOUNT,
    NULL UNS_AMOUNT,
    -- HAS.APPLICATION_NO,
    --HAS.ACCOUNT_ID,
    HAF.SCHEME_CODE,
    NULL AMOUNT_APPROVED,
    HAF.PRODUCT_CODE,
    HAF.PRODUCT_DESC1,
    HAF.FF_VC4 PRORGAM,
    HAF.FF_VC5 PROMOTION,
    --HAS.ACTIVE,
    HAD.SOURCE_OFFICE_ID,
    BRANCH.GEO_ID,
    HOD.HOD_PRODUCT_DESC1 BUSINESS_LINE,
    HOD.HOD_SUBPRODUCT_DESC1 BUSINESS_SUBLINE,
    HOD.HOD_FACILITY_DESC1 PRODUCT,--FACILITY,
    HOD.HOD_SCHEME_DESC1 FACILITY,
    HD.AGE_BRACKET_DESC1 AGE_BRACKET,
    HD.INCOME_BRACKET_DESC1 NET_INCOME_BRACKET,
    AGENCY.AGENCY_NAME1,
    AGENCY. AGENCY_TYPE_DESC1,
    HD.SCORECARD_DESC1 CIBIL_SCORE,
    HD.LTV_DESC1,
    HD.DBR_DESC1 ,
    HAC. EMPLOYEE_NAME1 RM_NAME,
    HAF.FF_VC1 PROPERTY_TPE,
    -- HBP.ACCOUNT_ID,
    --HBP.TXN_DT,
    NULL BOUNCE_MONTH,
    NULL BOUNCE_COUNT,
    NULL PRESENTATION_COUNT,
    NULL BOUNCE_RATIO,
    --HFR.ACCOUNT_ID
    --HFR.MONTHS FORE_MONTH,
    NULL FORE_POS,
    NULL PREV_FORE_POS,
    NULL MATURITY_POS,
    NULL PREV_MATURITY_POS,
    NULL ROI,
    NULL Portfolio_Rate,
    NVL((HAT.FF_N2 * HAT.BASE_AMOUNT),0) SOURCING_ROI,
   NVL((DECODE(NVL(HAT.FF_N2,0),0,0,HAT.BASE_AMOUNT)),0) SOURCING_BOOKED_AMT,
    HAT.BASE_AMOUNT BOOKED_AMT,
    TO_NUMBER(1)BOOKED_COUNT
  FROM HI_APPLICATION_FACILITIES HAF,
    TIME_CAL_DIM TIME1,
    HI_ACCOUNT_TXN HAT,
    -- HI_ACCOUNT_SNAPSHOT HAS,
    HI_APPLICATION_DEMOGRAPHICS HAD,
    UM_GEOGRAPHY BRANCH,
    HI_APPLICATION_AGENCY HAC,
    UM_AGENCY AGENCY,
    HDM_OFFERING_DIM HOD,
    HDM_CUSTOMER HD
  WHERE HAF.APPLICATION_NO = HAT.APPLICATION_NO
  AND BRANCH.GEO_CODE      = TO_CHAR(HAD.SOURCE_OFFICE_ID)
  AND HAT.APPLICATION_NO   = HAC.APPLICATION_NO
  AND HAF.APPLICATION_NO   = HAD.APPLICATION_NO
    --AND HAF.APPLICATION_NO   = HAD.APPLICATION_NO
    --AND HAT.ACCOUNT_ID       = HD.UID_NO (+)
  AND HAT.APPLICATION_NO = HD.UID_NO
  AND TIME1.DAY_ID (+)   = HAT.TXN_DT
  AND TIME1.ORG_ID       = HAT.ORG_ID
  AND HAT.TXN_TYPE_ID    =101
    --and HAS.ORG_ID=HAD.ORG_ID
    --AND HAS.ACCOUNT_ID = HAD.UID_NO (+)
    --AND has.active='Y'
  AND AGENCY.AGENCY_CODE = HAC.AGENCY_CODE
  AND HAF.ORG_ID         =777
  AND HAF.ACCOUNT_ID     = HAT.ACCOUNT_ID
  AND HAF.PRODUCT_CODE   = HOD.HOD_SCHEME_CODE
-- AND HAT.ACCOUNT_ID in ('1053537')   -------------------------------------------------------------
 /*
    union all
    ------------------------------------------------------------------to compute sourcing ROI
    SELECT TIME1.WEEK_OF_YEAR,
    TIME1.MONTH_LONG,
    TIME1.MONTH_LONG_DESC,
    TIME1.QUARTER_ID,
    TIME1.HALF_OF_YEAR_ID,
    TIME1.YEAR_ID,
    HAT.ORG_ID,
    HAT.TXN_DT TXN_DT,
    NULL MONTHLY_POS,
    NULL PREVIOUS_MONTH_POS_AMT,
    NULL Growth_Ratio,
    NULL CURRENT_POS,
    TO_NUMBER(0) POS_COUNT,
    NULL TOTAL_INTEREST_OS_BASE_AMOUNT,
    NULL NPA_POS_AMOUNT,
    NULL PROVISION_PERCENTAGE,
    NULL PROVISION_AMOUNT,
    NULL COVERAGE_RATIO,
    NULL COVERAGE_COUNT,
    NULL SLIPPAGE_AMOUNT,
    NULL UPGRADE_AMOUNT,
    NULL NORMAL_RECOVERY_AMOUNT,
    NULL UNC_AMOUNT,
    NULL UNS_AMOUNT,
    -- HAS.APPLICATION_NO,
    --HAS.ACCOUNT_ID,
    HAF.SCHEME_CODE,
    NULL AMOUNT_APPROVED,
    HAF.PRODUCT_CODE,
    HAF.PRODUCT_DESC1,
    HAF.FF_VC4 PRORGAM,
    HAF.FF_VC5 PROMOTION,
    --HAS.ACTIVE,
    HAD.SOURCE_OFFICE_ID,
    BRANCH.GEO_ID,
    HOD.HOD_PRODUCT_DESC1 BUSINESS_LINE,
    HOD.HOD_SUBPRODUCT_DESC1 BUSINESS_SUBLINE,
    HOD.HOD_FACILITY_DESC1 PRODUCT,--FACILITY,
    HOD.HOD_SCHEME_DESC1 FACILITY,
    HD.AGE_BRACKET_DESC1 AGE_BRACKET,
    HD.INCOME_BRACKET_DESC1 NET_INCOME_BRACKET,
    AGENCY.AGENCY_NAME1,
    AGENCY. AGENCY_TYPE_DESC1,
    HD.SCORECARD_DESC1 CIBIL_SCORE,
    HD.LTV_DESC1,
    HD.DBR_DESC1 ,
    HAC. EMPLOYEE_NAME1 RM_NAME,
    HAF.FF_VC1 PROPERTY_TPE,
    -- HBP.ACCOUNT_ID,
    --HBP.TXN_DT,
    NULL BOUNCE_MONTH,
    NULL BOUNCE_COUNT,
    NULL PRESENTATION_COUNT,
    NULL BOUNCE_RATIO,
    --HFR.ACCOUNT_ID
    --HFR.MONTHS FORE_MONTH,
    NULL FORE_POS,
    NULL PREV_FORE_POS,
    null  MATURITY_POS,
    null PREV_MATURITY_POS,
    NULL ROI,
    NULL PORTFOLIO_RATE,
   -- HAS.FF_N3 SOURCING_ROI,--(HAS.FF_N3 * HAT.BASE_AMOUNT) SOURCING_ROI,
   ROI_DISB_AMT SOURCING_ROI,
    null BOOKED_AMT,
    null BOOKED_COUNT
    FROM HI_APPLICATION_FACILITIES HAF,
    TIME_CAL_DIM TIME1,
    HI_ACCOUNT_TXN HAT,
    HI_ACCOUNT_SNAPSHOT HAS,
    HI_APPLICATION_DEMOGRAPHICS HAD,
    UM_GEOGRAPHY BRANCH,
    HI_APPLICATION_AGENCY HAC,
    UM_AGENCY AGENCY,
    HDM_OFFERING_DIM HOD,
    HDM_CUSTOMER HD,
     HV_ROI_DISB RD
    WHERE HAF.APPLICATION_NO = HAT.APPLICATION_NO
    AND BRANCH.GEO_CODE      = TO_CHAR(HAD.SOURCE_OFFICE_ID)
   AND HAT.APPLICATION_NO   = HAC.APPLICATION_NO
    AND HAF.APPLICATION_NO   = HAD.APPLICATION_NO
    --AND HAF.APPLICATION_NO   = HAD.APPLICATION_NO
    --AND HAT.ACCOUNT_ID       = HD.UID_NO (+)
    AND HAT.APPLICATION_NO = HD.UID_NO
    AND TIME1.DAY_ID (+)     = RD.TXN_DT
    AND TIME1.ORG_ID      = HAT.ORG_ID
    AND HAT.TXN_TYPE_ID      =101
    --and HAS.ORG_ID=HAD.ORG_ID
    AND HAS.ACCOUNT_ID = HAD.UID_NO
   -- AND has.active='Y'
   AND AGENCY.AGENCY_CODE   = HAC.AGENCY_CODE
    AND HAF.ORG_ID           =777
    AND HAF.ACCOUNT_ID       = HAT.ACCOUNT_ID
    AND HAF.PRODUCT_CODE     = HOD.HOD_SCHEME_CODE
    AND HAT.ACCOUNT_ID = RD.ACCOUNT_ID
    AND HAS.ACCOUNT_ID = RD.ACCOUNT_ID
AND HAT.ACCOUNT_ID in ('1053537') --------------------------------------------------------*/;
