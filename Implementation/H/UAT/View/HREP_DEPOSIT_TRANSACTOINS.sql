
  CREATE OR REPLACE FORCE VIEW HREP_DEPOSIT_TRANSACTOINS (MODULE_REF, COMPANY, DIVISION, PORTFOLIO, PORTFOLIO_NAME, PORTFOLIO_CATEGORY, PORTFOLIO_CATEGORY_NAME, PORTFOLIO_CCY, INSTRUMENT_TYPE, ASSET_GROUP_NAME, ASSET_CLASS, ASSET_NAME, TRANS_ID, TRANS_DATE, CURRENCY, TRANS_CODE, TRANS_NAME, INFLOW_OUTFLOW, MATURITY_DATE, NOOF_DAYS, COUPON_RATE, NET_AMOUNT_TCY, NET_AMOUNT_PCY, TOT_INTEREST_PCY, ACCR_INT_TCY, ACCR_INT_PCY, INT_RECEIVED_TCY, INT_RECEIVED_PCY, MATURITY_AMT_TCY, MATURITY_AMT_PCY, MATURITY_REFERENCE, NET_ASSET_VALUE, PER_NAV, TRANS_BASE_REF, TRANS_SRL_NO, COUNTERPARTY, COUNTERPARTY_NAME, CPARTY_GROUP, CPARTY_GROUP_NAME, IS_CPARTY_RELATED, IS_MATURED, IS_SYSGEN, MATURITY_DAYS, REMARKS, BUSINESS_DATE, DATA_SOURCE, TIME_STAMP) AS 
  select  'MMDEAL' as module_ref, mmdeal.amc_code as company, 'AMC' as division, mmdeal.scheme as portfolio, scheme.SCHEME_name as portfolio_name, scheme.port_type as portfolio_category,
        scheme.port_type as portfolio_category_name, scheme.currency as portfolio_ccy, assetype.instrument_type, decode(assetype.instrument_type, 'MM', 'Money Market Instruments', 'Others') as asset_group_name,
        assetype.asset_type as asset_class, assetype.broad_category as asset_name, mmdeal.deal_id as trans_id, mmdeal.value_date as trans_date, mmdeal.currency,
        mmdeal.tran_type as trans_code, trantype.name as trans_name, decode(trantype.pur_sal, 'P', 'I', 'O') as inflow_outflow,
       -- mmdeal.mat_date as maturity_date,---commented as no MATURITY DATE IN DEAL
       sec.mat_date as maturity_date,
      -- mmdeal.term as noof_days,
        MMDEAL.NOOFDAYS as noof_days,
       sec.interest as coupon_rate,
       --mmdeal.interest as coupon_rate,
       mmdeal.fcy_acc_amount as net_amount_tcy, mmdeal.ACC_AMOUNT as net_amount_pcy, --replaced amount with ACC_AMOUNT from DEALS, mmdeal.fcy_int_recble as tot_interest_tcy,
        mmdeal.int_recble as tot_interest_pcy, mmdeal.fcy_accr_int as accr_int_tcy, mmdeal.accr_int as accr_int_pcy, mmdeal.fcy_int_amt as int_received_tcy, -- fcy_int_recvd to fcy_int_amt
        mmdeal.int_amt as int_received_pcy,  --int_recvd to int_amt
        decode(mmdeal.deal_id, null, (mmdeal.fcy_acc_amount+mmdeal.fcy_int_recble), mmdeal.fcy_acc_amount) as maturity_amt_tcy, ---added to replace mmtxns with mmdeal
        decode(mmdeal.deal_id, null, (mmdeal.ACC_AMOUNT+mmdeal.int_recble), MMDEAL.ACC_AMOUNT) as maturity_amt_pcy,  --replaced amount with ACC_AMOUNT and FCY_ACC_AMOUNT from DEALS
        mmdeal.deal_id as maturity_reference,
        /*
        decode(mmtxns.deal_id, null, (mmdeal.fcy_amount+mmdeal.fcy_int_recble), mmtxns.fcy_amount) as maturity_amt_tcy,
        decode(mmtxns.deal_id, null, (mmdeal.amount+mmdeal.int_recble), mmtxns.amount) as maturity_amt_pcy,
        mmtxns.deal_id as maturity_reference,
        */
        scheme.nav as net_asset_value,
        decode(scheme.nav, 0, 0, mmdeal.ACC_AMOUNT/scheme.nav*100) as per_nav, --replaced amount with ACC_AMOUNT from DEALS, mmdeal.book_date as entry_date, mmdeal.app_refer as trans_ref,
        -- mmdeal.payrec_refer as trans_base_ref, commented as column not found
        0 as trans_base_ref,
        1 as trans_srl_no, mmdeal.cparty_id as counterparty, cparty.name as counterparty_name, cparty.coup_type as cparty_group, cparty.coup_type as cparty_group_name,
        nvl(cparty.related_yn, 'N') as is_cparty_related,
        case when sec.mat_date < scheme.cur_date then 'Y' else 'N' end as is_matured, mmdeal.sysgen_y_n as is_sysgen,
       (sec.mat_date - scheme.cur_date) as maturity_days, mmdeal.remarks,
        scheme.cur_date as business_date, 'HEXGENDBDATA' as data_source, current_timestamp as time_stamp
from    sysparam, HM_SCHEME scheme, HM_deal mmdeal, HM_ASSET_TYPE assetype, HM_TRAN_TYPE trantype, HM_CPARTY cparty, -- , mmtxns,
HM_security sec
where   sec.security = mmdeal.security --added for bringing maturity date from Security master
and
sysparam.amc_code   = scheme.amc_code
and     sysparam.amc_code   = mmdeal.amc_code
and     scheme.scheme       = mmdeal.scheme
and     mmdeal.value_date   > scheme.prv_yrend
and     trantype.tran_type  = mmdeal.tran_type
and     assetype.asset_type = mmdeal.asset_type
and mmdeal.asset_type = 25 ---added for deposit
and     cparty.cparty_id    = mmdeal.cparty_id
/*
and     sysparam.rectype    = 'L'
and     scheme.rectype      = 'L'
and     mmdeal.rectype      = 'L'
and     assetype.rectype    = 'L'
--and     trantype.rectype    = 'L'
and     cparty.rectype      = 'L'
                                   */;
 
