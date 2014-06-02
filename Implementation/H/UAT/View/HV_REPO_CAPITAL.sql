
  CREATE OR REPLACE  VIEW HV_REPO_CAPITAL (MODULE_REF, COMPANY, DIVISION, PORTFOLIO, PORTFOLIO_NAME, PORTFOLIO_CATEGORY, PORTFOLIO_CATEGORY_NAME, PORTFOLIO_CCY, PORTFOLIO_PLAN, PORTFOLIO_CLASS, PORTFOLIO_CLASS_NAME, TRANS_ID, TRANS_DATE, CURRENCY, TRANS_CODE, TRANS_NAME, INFLOW_OUTFLOW, UNITS, RATE, NET_AMOUNT_TCY, NET_AMOUNT_PCY, ACQU_COST_TCY, ACQU_COST_PCY, PROFIT_LOSS_TCY, PROFIT_LOSS_PCY, DIV_EQU_AMOUNT_TCY, DIV_EQU_AMOUNT_PCY, ENTRY_EXIT_FEE_TCY, ENTRY_EXIT_FEE_PCY, SETL_DATE, ENTRY_DATE, TRANS_REF, TRANS_BASE_REF, TRANS_SRL_NO, IS_SYSGEN, REMARKS, BUSINESS_DATE, DATA_SOURCE, TIME_STAMP) AS 
  select  'REPSAL' as module_ref, repsal.amc_code as company, 'AMC' as division, repsal.scheme as portfolio, scheme.SCHEME_name as portfolio_name, scheme.port_type as portfolio_category,
        scheme.port_type as portfolio_category_name, scheme.currency as portfolio_ccy, 'DIR' as portfolio_plan, schclass.schclass as portfolio_class,
        schclass.name as portfolio_class_name, repsal.deal_id as trans_id, repsal.value_date as trans_date, repsal.currency, repsal.tran_type as trans_code,
        trantype.name as trans_name, decode(trantype.pur_sal, 'P', 'I', 'O') as inflow_outflow, repsal.units, repsal.rate, repsal.fcy_amount as net_amount_tcy,
        repsal.amount as net_amount_pcy, repsal.acqu_cost as acqu_cost_tcy, repsal.acqu_cost as acqu_cost_pcy, repsal.prft_loss as profit_loss_tcy,
        repsal.prft_loss as profit_loss_pcy, repsal.divequ_amt as div_equ_amount_tcy, repsal.divequ_amt as div_equ_amount_pcy, repsal.loadamount as entry_exit_fee_tcy,
        repsal.loadamount as entry_exit_fee_pcy, repsal.payment_date as setl_date, repsal.book_date as entry_date, repsal.app_refer as trans_ref,
        null as trans_base_ref, 1 as trans_srl_no, repsal.sysgen_y_n as is_sysgen, repsal.remarks,
        scheme.cur_date as business_date, 'HEXGENDBDATA' as data_source, current_timestamp as time_stamp
from    sysparam,HM_SCHEME scheme, HM_SCHCLASS schclass, HI_REPSAL_CURR repsal,HM_TRAN_TYPE trantype
where   sysparam.amc_code     = scheme.amc_code
and     sysparam.amc_code     = scheme.amc_code
and     sysparam.amc_code     = repsal.amc_code
and     scheme.scheme         = schclass.scheme
and     scheme.scheme         = repsal.scheme
and     schclass.schclass     = repsal.schclass
and     repsal.value_date     > scheme.prv_yrend
and     trantype.tran_type    = repsal.tran_type;
 
