--------------------------------------------------------
--  File created - Friday-October-18-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View HV_APPLICATION_DATA
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "RIGEL"."HV_APPLICATION_DATA" ("SR_NO", "LOCATION", "BRANCH_NAME", "RELATIONSHIP_OFFICER", "SALES_MANAGER", "SOURCE_DSA_DIRECT_BRANCH", "PROGRAM_REGULAR_HIGH_YIELD", "PRODUCT_HL_HE", "PRODUCT_VARIANT", "SCHEME", "LOGIN_DATE", "RELOGIN_STATUS", "CONSTITUTION", "LOAN_AMT_APPLIED", "LOGIN_LMF_AMOUNT", "SECURITY_PROPERTY", "CURRENT_STATUS", "CURRENT_STATUS_DATE", "MONTH", "YEAR", "WEEK", "FIRST_STAGE_CREDIT_DECISION", "FIRST_STAGE_DECISION_DATE", "FINAL_DECISION_AMT", "REJECTION_REASON", "APPROVAL_COUNT", "REJECTED_COUNT", "DELOGGED_COUNT", "PENDING_COUNT", "DISCREPANT_COUNT", "SENT_FOR_APPROVAL_COUNT", "APPROVED_AMOUNT", "REJECTED_AMOUNT", "DELOGGED_AMOUNT", "PENDING_AMOUNT", "DISCREPANT_AMOUNT", "SENT_FOR_APPROVAL_AMOUNT") AS 
  SELECT "SR_NO",
  "LOCATION",
  "BRANCH_NAME",
  "RELATIONSHIP_OFFICER",
  "SALES_MANAGER",
  "SOURCE_DSA_DIRECT_BRANCH",
  "PROGRAM_REGULAR_HIGH_YIELD",
  "PRODUCT_HL_HE",
  "PRODUCT_VARIANT",
  "SCHEME",
  "LOGIN_DATE",
  "RELOGIN_STATUS",
  "CONSTITUTION",
  (LOAN_AMT_APPLIED/10000000) LOAN_AMT_APPLIED,
  "LOGIN_LMF_AMOUNT",
  "SECURITY_PROPERTY",
  "CURRENT_STATUS",
current_status_date,
  NVL(MONTH,TO_CHAR(sysdate,'MONTH')) MONTH,
  nvl(YEAR,to_char(sysdate,'YYYY')) YEAR,
  nvl(WEEK,to_char(sysdate,'WW')) WEEK,
  "FIRST_STAGE_CREDIT_DECISION",
  "FIRST_STAGE_DECISION_DATE",
  (FINAL_DECISION_AMT/10000000) FINAL_DECISION_AMT,
  "REJECTION_REASON",
  "APPROVAL_COUNT",
  "REJECTED_COUNT",
  "DELOGGED_COUNT",
  "PENDING_COUNT",
  "DISCREPANT_COUNT",
  "SENT_FOR_APPROVAL_COUNT",
  (
  CASE
    WHEN CURRENT_STATUS='APPROVED'
    THEN (LOAN_AMT_APPLIED/10000000)
    ELSE 0
  END) APPROVED_Amount,
  (
  CASE
    WHEN CURRENT_STATUS='REJECTED'
    THEN (LOAN_AMT_APPLIED/10000000)
    ELSE 0
  END) REJECTED_Amount,
  (
  CASE
    WHEN CURRENT_STATUS='DELOGGED'
    THEN (LOAN_AMT_APPLIED/10000000)
    ELSE 0
  END) DELOGGED_Amount,
  (
  CASE
    WHEN TRIM(CURRENT_STATUS)='PENDING WITH CREDIT'
    THEN (LOAN_AMT_APPLIED/10000000)
    ELSE 0
  END) PENDING_Amount,
  (
  CASE
    WHEN CURRENT_STATUS='DISCREPANT'
    THEN (LOAN_AMT_APPLIED/10000000)
    ELSE 0
  END)DISCREPANT_Amount,
  (
  CASE
    WHEN CURRENT_STATUS='SENT FOR APPROVAL'
    THEN (LOAN_AMT_APPLIED/10000000)
    ELSE 0
  END)SENT_FOR_APPROVAL_AMount
FROM application_Mortgage_data
GROUP BY "SR_NO",
  "LOCATION",
  "BRANCH_NAME",
  "RELATIONSHIP_OFFICER",
  "SALES_MANAGER",
  "SOURCE_DSA_DIRECT_BRANCH",
  "PROGRAM_REGULAR_HIGH_YIELD",
  "PRODUCT_HL_HE",
  "PRODUCT_VARIANT",
  "SCHEME",
  "LOGIN_DATE",
  "RELOGIN_STATUS",
  "CONSTITUTION",
  "LOAN_AMT_APPLIED",
  "LOGIN_LMF_AMOUNT",
  "SECURITY_PROPERTY",
  "CURRENT_STATUS",
  "MONTH",
  "YEAR",
  "WEEK",
  "FIRST_STAGE_CREDIT_DECISION",
  "FIRST_STAGE_DECISION_DATE",
  "FINAL_DECISION_AMT",
  "REJECTION_REASON",
  "APPROVAL_COUNT",
  "REJECTED_COUNT",
  "DELOGGED_COUNT",
  "PENDING_COUNT",
  "DISCREPANT_COUNT",
  "SENT_FOR_APPROVAL_COUNT",current_status_date;
