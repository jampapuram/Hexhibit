
  CREATE OR REPLACE  VIEW HV_SECURITY_TRANSACTIONS (MODULE_REF, COMPANY, DIVISION, PORTFOLIO, PORTFOLIO_NAME, PORTFOLIO_CCY, ASSET_GROUP, ASSET_CLASS, ASSET_NAME, SECURITY, SECURITY_NAME, TRANS_ID, TRANS_DATE, CURRENCY, TRANS_CODE, TRANS_NAME, INFLOW_OUTFLOW, QUANTITY, PRICE, GROSS_AMT_TCY, GROSS_AMT_PCY, TRADE_FEE_TCY, TRADE_FEE_PCY, GROSS_INT_TCY, GROSS_INT_PCY, NET_AMOUNT_TCY, NET_AMOUNT_PCY, ACQU_COST_TCY, ACQU_COST_PCY, GROSS_AOD_TCY, GROSS_AOD_PCY, REAL_GL_TCY, REAL_GL_PCY, PURCHASE_YIELD, BRK_AMOUNT_TCY, BRK_AMOUNT_PCY, SERVICE_TAX_TCY, SERVICE_TAX_PCY, SETL_DATE, ENTRY_DATE, TRANS_REF, TRANS_BASE_REF, TRANS_SRL_NO, MATURITY_DATE, COUPON_RATE, IS_FIXED_INCOME, BROKER, BROKER_NAME, COUNTERPARTY, COUNTERPARTY_NAME, BROKER_GROUP, BROKER_GROUP_NAME, CPARTY_GROUP, CPARTY_GROUP_NAME, IS_SYSGEN, IS_BROKER_RELATED, IS_CPARTY_RELATED, IS_SYS_BROKER, IS_TRANSFER, TRF_PORTFOLIO, TRF_PORTFOLIO_NAME, IS_TRF_PORTFOLIO_RELATED, REMARKS, BUSINESS_DATE, DATA_SOURCE, TIME_STAMP) AS 
  select  'DEAL' as module_ref, deal.amc_code as company, 'AMC' as division, deal.scheme as portfolio, scheme.name as portfolio_name, scheme.currency as portfolio_ccy,
        security.asset_group, security.asset_class, security.asset_name, security.security, security.security_name, deal.deal_id as trans_id, deal.value_date as trans_date,
        DEAL.CURRENCY, DEAL.TRAN_TYPE AS TRANS_CODE, TRANTYPE.NAME AS TRANS_NAME, DECODE(TRANTYPE.PUR_SAL, 'P', 'I', 'O') AS INFLOW_OUTFLOW, DEAL.UNITS AS QUANTITY,
        deal.rate as price, deal.NETT_VAL as gross_amt_tcy, deal.gross_val as gross_amt_pcy, 0 as trade_fee_tcy, 0 as trade_fee_pcy, deal.fcy_gross_int as gross_int_tcy,
        deal.gross_int as gross_int_pcy, deal.fcy_nett_val as net_amount_tcy, deal.nett_val as net_amount_pcy, deal.fcy_acqu_cost as acqu_cost_tcy, deal.acqu_cost as acqu_cost_pcy,
        deal.fcy_premdisc_amt as gross_aod_tcy, deal.premdisc_amt as gross_aod_pcy, deal.fcy_prft_loss as real_gl_tcy, deal.prft_loss as real_gl_pcy, deal.pur_yield as purchase_yield,
        deal.fcy_brk_commn as brk_amount_tcy, deal.brk_commn as brk_amount_pcy, deal.fcy_service_tax as service_tax_tcy, deal.service_tax as service_tax_pcy,
        deal.del_date as setl_date, deal.book_date as entry_date, deal.app_refer as trans_ref, deal.alloc_deal_id as trans_base_ref, 1 as trans_srl_no, security.maturity_date,
        security.coupon_rate, security.is_fixed_income, deal.broker, broker.name as broker_name, deal.cparty_id as counterparty, cparty.name as counterparty_name,
        broker.brk_group as broker_group, broker.brk_group as broker_group_name, cparty.couptype as cparty_group, cparty.couptype as cparty_group_name, deal.sysgen_y_n as is_sysgen,
        nvl(broker.related_yn, 'N') as is_broker_related, nvl(cparty.related_yn, 'N') as is_cparty_related, decode(nvl(deal.broker, 'NULL'), sysparam.broker, 'Y', 'N') as is_sys_broker,
        decode(transfer.tran_type, null, 'N', 'Y') as is_transfer, decode(transfer.tran_type, null, null, deal.tran_type, transfer.scheme_n, transfer.scheme) as trf_portfolio,
        decode(transfer.tran_type, null, null, trfscheme.name) as trf_portfolio_name, nvl(trfscheme.related_y_n, 'N') as is_trf_portfolio_related, deal.remarks,
        scheme.cur_date as business_date, 'HEXGENDBDATA' as data_source, current_timestamp as time_stamp
from    sysparam, scheme, deal, v_reps_security_detail security, trantype, broker, cparty, interscheme transfer, scheme trfscheme
where   sysparam.amc_code   = scheme.amc_code
and     sysparam.amc_code   = deal.amc_code
and     scheme.scheme       = deal.scheme
and     deal.value_date     > scheme.prv_yrend
and     trantype.tran_type  = deal.tran_type
and     deal.security       = security.security
and     sysparam.rectype    = 'L'
and     scheme.rectype      = 'L'
and     deal.rectype        = 'L'
and     trantype.rectype    = 'L'
and     broker.broker    (+)= deal.broker
and     broker.rectype   (+)= 'L'
and     cparty.cparty_id (+)= deal.cparty_id
and     cparty.rectype   (+)= 'L'
and     transfer.amc_code(+)= deal.amc_code
and     transfer.deal_id (+)= deal.app_refer
and     transfer.rectype (+)= 'L'
and     trfscheme.scheme    = decode(transfer.tran_type, null, deal.scheme, deal.tran_type, transfer.scheme_n, transfer.scheme)
and     trfscheme.rectype   = 'L'
union all
select  'FUTUREDEAL' as module_ref, deal.amc_code as company, 'AMC' as division, deal.scheme as portfolio, scheme.name as portfolio_name, scheme.currency as portfolio_ccy,
        assetype.asset_group, security.asset_type as asset_class, assetype.name as asset_name, security.indxfuture as security, security.name as security_name, deal.deal_id as trans_id,
        deal.value_date as trans_date, deal.currency, deal.tran_type as trans_code, trantype.name as trans_name, decode(trantype.pur_sal, 'P', 'I', 'O') as inflow_outflow,
        deal.units as quantity, deal.rate as price, deal.fcy_gross_val as gross_amt_tcy, deal.gross_val as gross_amt_pcy, 0 as trade_fee_tcy, 0 as trade_fee_pcy,
        0 as gross_int_tcy, 0 as gross_int_pcy, deal.fcy_nett_val as net_amount_tcy, deal.nett_val as net_amount_pcy, deal.fcy_acqu_cost as acqu_cost_tcy,
        deal.acqu_cost as acqu_cost_pcy, 0 as gross_aod_tcy, 0 as gross_aod_pcy, deal.fcy_prft_loss as real_gl_tcy, deal.prft_loss as real_gl_pcy, 0 as purchase_yield,
        deal.fcy_brk_commn as brk_amount_tcy, deal.brk_commn as brk_amount_pcy, deal.fcy_service_tax as service_tax_tcy, deal.service_tax as service_tax_pcy,
        deal.del_date as setl_date, deal.book_date as entry_date, deal.app_refer as trans_ref, null as trans_base_ref, 1 as trans_srl_no, security.mat_date as maturity_date,
        0 as coupon_rate, 'N' as is_fixed_income, deal.broker, broker.name as broker_name, deal.cparty_id as counterparty, cparty.name as counterparty_name,
        broker.brk_group as broker_group, broker.brk_group as broker_group_name, cparty.couptype as cparty_group, cparty.couptype as cparty_group_name, deal.sysgen_y_n as is_sysgen,
        nvl(broker.related_yn, 'N') as is_broker_related, nvl(cparty.related_yn, 'N') as is_cparty_related, decode(nvl(deal.broker, 'NULL'), sysparam.broker, 'Y', 'N') as is_sys_broker,
        'N' as is_transfer, null as trf_portfolio, null as trf_portfolio_name, 'N' as is_trf_portfolio_related, deal.remarks,
        scheme.cur_date as business_date, 'HEXGENDBDATA' as data_source, current_timestamp as time_stamp
from    sysparam, scheme, futuredeal deal, indxfuture security, assetype, trantype, broker, cparty
where   sysparam.amc_code   = scheme.amc_code
and     sysparam.amc_code   = deal.amc_code
and     scheme.scheme       = deal.scheme
and     deal.value_date     > scheme.prv_yrend
and     trantype.tran_type  = deal.tran_type
and     security.indxfuture = deal.indxfuture
and     assetype.asset_type = security.asset_type
and     sysparam.rectype    = 'L'
and     scheme.rectype      = 'L'
and     deal.rectype        = 'L'
and     assetype.rectype    = 'L'
and     security.rectype    = 'L'
and     trantype.rectype    = 'L'
and     broker.broker    (+)= deal.broker
and     broker.rectype   (+)= 'L'
and     cparty.cparty_id (+)= deal.cparty_id
and     cparty.rectype   (+)= 'L'
union all
select  'OPTIONSDEAL' as module_ref, deal.amc_code as company, 'AMC' as division, deal.scheme as portfolio, scheme.name as portfolio_name, scheme.currency as portfolio_ccy,
        assetype.asset_group, deal.asset_type as asset_class, assetype.name as asset_name, deal.option_security as security, deal.option_security as security_name,
        deal.deal_id as trans_id,
        deal.value_date as trans_date, deal.currency, deal.tran_type as trans_code, trantype.name as trans_name, decode(trantype.pur_sal, 'P', 'I', 'O') as inflow_outflow,
        deal.units as quantity, deal.strike_price as price, deal.fcy_gross_val as gross_amt_tcy, deal.gross_val as gross_amt_pcy, 0 as trade_fee_tcy, 0 as trade_fee_pcy,
        0 as gross_int_tcy, 0 as gross_int_pcy, deal.fcy_nett_val as net_amount_tcy, deal.nett_val as net_amount_pcy, deal.fcy_acqu_cost as acqu_cost_tcy,
        deal.acqu_cost as acqu_cost_pcy, 0 as gross_aod_tcy, 0 as gross_aod_pcy, deal.fcy_prft_loss as real_gl_tcy, deal.prft_loss as real_gl_pcy, 0 as purchase_yield,
        deal.fcy_brk_commn as brk_amount_tcy, deal.brk_commn as brk_amount_pcy, deal.fcy_service_tax as service_tax_tcy, deal.service_tax as service_tax_pcy,
        deal.value_date as setl_date, deal.book_date as entry_date, deal.app_refer as trans_ref, null as trans_base_ref, 1 as trans_srl_no, deal.expiry_date as maturity_date,
        0 as coupon_rate, 'N' as is_fixed_income, deal.broker, broker.name as broker_name, deal.cparty_id as counterparty, cparty.name as counterparty_name,
        broker.brk_group as broker_group, broker.brk_group as broker_group_name, cparty.couptype as cparty_group, cparty.couptype as cparty_group_name, 'N' as is_sysgen,
        nvl(broker.related_yn, 'N') as is_broker_related, nvl(cparty.related_yn, 'N') as is_cparty_related, decode(nvl(deal.broker, 'NULL'), sysparam.broker, 'Y', 'N') as is_sys_broker,
        'N' as is_transfer, null as trf_portfolio, null as trf_portfolio_name, 'N' as is_trf_portfolio_related, deal.remarks,
        scheme.cur_date as business_date, 'HEXGENDBDATA' as data_source, current_timestamp as time_stamp
from    sysparam, scheme, optionsdeal deal, assetype, trantype, broker, cparty
where   sysparam.amc_code   = scheme.amc_code
and     sysparam.amc_code   = deal.amc_code
and     scheme.scheme       = deal.scheme
/*and     deal.value_date     > scheme.prv_yrend*/
and     trantype.tran_type  = deal.tran_type
and     assetype.asset_type = deal.asset_type
and     sysparam.rectype    = 'L'
and     scheme.rectype      = 'L'
and     deal.rectype        = 'L'
and     assetype.rectype    = 'L'
and     trantype.rectype    = 'L'
and     broker.broker    (+)= deal.broker
and     broker.rectype   (+)= 'L'
AND     CPARTY.CPARTY_ID (+)= DEAL.CPARTY_ID
and     cparty.rectype   (+)= 'L';
 
