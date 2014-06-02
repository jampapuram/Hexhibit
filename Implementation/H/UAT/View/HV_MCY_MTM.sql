
  CREATE OR REPLACE  VIEW HV_MCY_MTM (MCY_DATE, FANDO, P, CM_CODE, MKT_TYPE, CP_CODE, ACC_TYPE, CLIENT_ACC_CODE, INSTR_TYPE, SYMBOL, EXPIRY, STRIKE_PRICE, OPTION_TYPE, CA_LEVEL, BF_LONG_QTY, BF_LONG_VALUE, BF_SHORT_QTY, BF_SHORT_VALUE, OP_PUR_QTY, OP_PUR_VALUE, OP_SALE_QTY, OP_SALE_VALUE, PRE_LONG_QTY_BEF_EXERCISE, PRE_LONG_VAL_BEF_EXERCISE, PRE_SHORT_QTY_BEF_ASS, PRE_SHORT_VAL_BEF_ASS, EXE_QTY, ASS_QTY, POST_LONG_QTY_BEF_EXE, POST_LONG_VAL_BEF_EXE, POST_SHORT_QTY_BEF_ASS, POST_SHORT_VAL_BEF_ASS, SETTL_PRICE, NET_PRM, MTM, FINAL_SETLL, EXERCISE_VALUE, EXCEL_MTM, EXCEL_DIFF, AMOUNT, MCY_DIFF, VALUE_DATE) AS 
  SELECT MCY_DATE,
    fando,
    p,
    CM_CODE,
    mkt_type,
    cp_code,
    acc_type,
    CLIENT_ACC_CODE,
    instr_type,
    SYMBOL,
    expiry,
    strike_price,
    OPTION_TYPE,
    ca_level,
    bf_long_qty,
    bf_long_value,
    bf_short_qty,
    bf_short_value,
    op_pur_qty,
    OP_PUR_VALUE,
    op_sale_qty,
    op_sale_value,
    pre_long_qty_bef_exercise,
    PRE_LONG_VAL_BEF_EXERCISE,
    pre_short_qty_bef_ass,
    PRE_SHORT_VAL_BEF_ASS,
    exe_qty,
    ass_qty,
    post_long_qty_bef_exe,
    POST_LONG_VAL_BEF_EXE,
    post_short_qty_bef_ass,
    post_short_val_bef_ass,
    settl_price,
    NET_PRM,
    mtm,
    final_setll,
    exercise_value,
    ((ht.mtm_prev       -ht.mkt_price)*-ht.units)                   as excel_mtm,
    round(((ht.mtm_prev -ht.mkt_price)*-ht.units)-mtm-final_setll,2)as excel_diff,  
    accent.amount,
    ( -((ht.mtm_prev       -ht.mkt_price)*-ht.units) - accent.amount) as mcy_diff, 
    ACCENT.VALUE_DATE
  FROM hi_total_mtm_deal ht,
    hupd_mcy_upload hu,
    hi_accent_curr accent,hi_mktprice_curr mktprice
  WHERE ht.code_expiry = ( (symbol)
    ||''
    || to_char((expiry - to_date('01-JAN-1900'))+2))
 and   accent.value_date = mktprice.value_date
and accent.security = mktprice.security
and (mktprice.source not in ('CRISIL','BSE','GSEC','DEBT'))
--and (ACCENT.VALUE_DATE='08 Jan 2014')
and (accent.scheme      ='HDFCAR')
and (accent.level_1     ='111520')
and accent.security = ht.indxfuture
and  accent.value_Date = ht.value_date;
 
