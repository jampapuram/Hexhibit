
  CREATE OR REPLACE  VIEW HVREP_GL_BALANCE_DETAIL (COMPANY, DIVISION, PORTFOLIO, PORTFOLIO_NAME, BS_PL_GROUP, ACCOUNT_TYPE, ACCOUNT_TYPE_NAME, NAV_GROUP, NAV_GROUP_NAME, SORT_ORDER, ACCOUNT_GROUP, ACCOUNT_GROUP_NAME, CONTROL_AC, CONTROL_AC_NAME, GL_ACCOUNT, GL_ACCOUNT_NAME, CURRENCY, PORTFOLIO_CCY, TRANS_ID, TRANS_DATE, ENTRY_DATE, TRANS_CODE, TRANS_REF, TRANS_BASE_REF, LEVEL_1, LEVEL_2, AMOUNT_TCY, AMOUNT_PCY, SECURITY, BROKER, COUNTERPARTY, MODULE_REF, NARRATION, BUSINESS_DATE, DATA_SOURCE, TIME_STAMP) AS 
  SELECT scheme.scheme AS company,
    'AMC'               AS division,
    scheme.scheme       AS portfolio,
    SCHEME.SCHEME_NAME  AS PORTFOLIO_NAME,
    NULL                AS BS_PL_GROUP,       -- account.ie_bs_type                                                                                                   AS bs_pl_group,
    NULL                AS ACCOUNT_TYPE,      -- account.ie_bs_type                                                                                                   AS account_type,
    NULL                AS account_type_name, --DECODE(account.ie_bs_type, 'A', 'Assets', 'L', 'Liability', 'I', 'Income', 'E', 'Expense', 'C', 'Capital', 'Others') AS account_type_name,
    NULL                AS nav_group,
    NULL                AS nav_group_name,
    0                   AS sort_order,
    NULL                AS account_group,
    null                as ACCOUNT_GROUP_NAME,
   null as  CONTROL_AC, --aclevel.control_ac,
   null as CONTROL_AC_NAME,-- aclevel.name    AS control_ac_name,
   null as GL_ACCOUNT,--- account.account as GL_ACCOUNT,
   null as GL_ACCOUNT_NAME, -- account.name    as GL_ACCOUNT_NAME,
   NULL AS currency, --account.currency,
    scheme.currency     AS portfolio_ccy,
    accent.deal_id      AS trans_id,
    accent.value_date   AS trans_date,
    accent.book_date    AS entry_date,
    accent.tran_type    AS trans_code,
    accent.app_refer    AS trans_ref,
    accent.payrec_refer AS trans_base_ref,
    accent.level_1,
    accent.level_2,
    accent.fcy_amount AS amount_tcy,
    accent.amount     AS amount_pcy,
    accent.security,
    accent.broker_cparty AS broker,
    accent.broker_cparty AS counterparty,
    NULL                 AS module_ref,
    accent.narration,
    scheme.cur_date   AS business_date,
    'HEXGENDBDATA'    AS data_source,
    CURRENT_TIMESTAMP AS time_stamp
  FROM HM_SCHEME SCHEME,
    --   HI_ACLEVEL_CURR aclevel,  commented by Ram removed the aclevl table
   -- HI_ACCOUNT_CURR account,
    HI_ACCENT_CURR ACCENT
  WHERE
    /*scheme.amc_code           = aclevel.amc_code
    AND
    scheme.amc_code   = account.amc_code
  and*/ SCHEME.AMC_CODE = ACCENT.AMC_CODE
     /*AND scheme.scheme               = aclevel.scheme
  AND scheme.scheme               = account.scheme*/
  and SCHEME.SCHEME               = ACCENT.SCHEME
/*  AND aclevel.control_ac          = account.level_1
  AND aclevel.control_ac          = accent.level_1
  AND NVL(accent.level_2, 'NULL') = NVL(account.level_2, 'NULL')
  AND NVL(accent.level_3, 'NULL') = NVL(account.level_3, 'NULL')
  AND NVL(accent.level_4, 'NULL') = NVL(account.level_4, 'NULL')
  AND NVL(ACCENT.LEVEL_5, 'NULL') = NVL(account.LEVEL_5, 'NULL')
  AND accent.currency             = account.currency*/
  and SCHEME.RECTYPE              = 'L'
  /*AND aclevel.rectype             = 'L'
  and account.RECTYPE   = 'L'
  and  account.LEVEL_1 like '8%'
  AND  ACCENT.level_1 LIKE '8%'*/
  AND ACCENT.VALUE_DATE > SCHEME.PRV_YREND;
 
