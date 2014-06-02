
  CREATE OR REPLACE  VIEW HV_ANALYSIS (SCHEME, AUM, SUBSCRIPTION, REDEMPTION, NET_PERFORMANCE, DIVIDEND, NET_SUBSCRIPTION, AUM_POSTSUBSCRIPTION, PROFIT_BOOK, LOSS_BOOKED, NET_PROFIT, UNRELIASED, TOT_VALUATION, INC_DIV, INC_INT, OTH_TOTAL, INV_PER, AUM_POST, OPE_EXP, IIE, INC_DIV_EXP, TOTAL_INCOME_EXP, AUM_ASON, AUM_GROWTH, SCHEME_TYPE, VALUE_DATE) AS 
  SELECT scheme,
    AUM,
    SUBSCRIPTION,
    redemption,
    NET_PERFORMANCE,
    dividend,
    net_subscription,
    aum_postsubscription,
    profit_book,
    loss_booked,
    SUM(profit_book    + loss_booked)                                      AS net_profit,
    ROUND((jan         - decm) /10000000,2)                                AS unreliased,
    ( ( SUM(profit_book+ loss_booked) ) + ROUND((jan - decm) /10000000,2)) AS tot_valuation,
    inc_div,
    inc_int,
    SUM(inc_div           + inc_int)                                                                                                AS oth_total,
    ( ( ( SUM(profit_book + loss_booked) ) + ROUND((jan - decm) /10000000,2)) + (SUM(inc_div + inc_int)))                           AS inv_per,
    (aum_postsubscription + (( ( ( SUM(profit_book+ loss_booked) ) + ROUND((jan - decm) /10000000,2)) + (SUM(inc_div + inc_int))))) AS aum_post,
    ope_exp,
    iie,
    inc_div_exp,
    SUM(ope_exp             + iie + inc_div_exp)                                                                                                                                 AS total_income_exp,
    ((aum_postsubscription  + (( ( ( sum(profit_book+ loss_booked) ) + round((jan - decm) /10000000,2)) + (sum(inc_div + inc_int))))) + sum(ope_exp + iie + inc_div_exp))        as aum_ason,
    (((aum_postsubscription + (( ( ( sum(profit_book+ loss_booked) ) + round((jan - decm) /10000000,2)) + (sum(inc_div + inc_int))))) + sum(ope_exp + iie + inc_div_exp)) - aum) as aum_growth,
    SCHEME_TYPE,value_date
  FROM
    (SELECT weeknav.scheme,
      SUM(ROUND((WEEKNAV.LAST_NET_ASSETS) /10000000,2))                                                                                                 AS AUM,
      ((REPSAL.INFLOW                     -REPSAL.DIVIDEND) -LOAD.NET_AMOUNT)                                                                           AS SUBSCRIPTION,
      repsal.outflow                                                                                                                                    AS redemption,
      (((REPSAL.INFLOW -REPSAL.DIVIDEND)-LOAD.NET_AMOUNT) - REPSAL.OUTFLOW)                                                                             AS NET_PERFORMANCE,
      repsal.dividend                                                                                                                                   AS dividend,
      ( (((repsal.inflow                    -repsal.dividend)-load.net_amount) - repsal.outflow) + repsal.dividend)                                     AS net_subscription,
      ( SUM(ROUND((weeknav.last_net_assets) /10000000,2)) + ( (((repsal.inflow -repsal.dividend)-load.net_amount) - repsal.outflow) + repsal.dividend)) AS aum_postsubscription,
      NVL(income.profit,0)                                                                                                                              AS profit_book,
      NVL(income.loss,0)                                                                                                                                AS loss_booked ,
      NVL(appdepp.dec,0)                                                                                                                                AS decm,
      NVL(appdepp.jan,0)                                                                                                                                AS jan,
      NVL(income.dividend,0)                                                                                                                            AS inc_div,
      NVL(income.interest,0)                                                                                                                            AS inc_int,
      NVL(income.operating_expense,0)                                                                                                                   AS ope_exp,
      NVL(income.iie,0)                                                                                                                                 AS iie,
      nvl(income.dividend_expense,0)                                                                                                                    as inc_div_exp,
      SCHEME.SCHEMETYPE AS SCHEME_TYPE, 
load.value_date
    FROM HI_WEEKNAV_CURR WEEKNAV,
      HV_REPSAL REPSAL,
      hv_load load,
      hv_income_expense income,
      hv_app_depp appdepp, 
      hm_scheme_alt SCHEME
    WHERE WEEKNAV.SCHEME        = REPSAL.SCHEME
    AND WEEKNAV.SCHEME          = LOAD.SCHEME
    AND weeknav.scheme          = income.scheme
    and weeknav.scheme          = appdepp.scheme
    AND WEEKNAV.SCHEME          = SCHEME.SCHEMECODE
    and repsal.value_date = load.value_date
    and repsal.value_date = INCOME.VALUE_DATE
    AND WEEKNAV.SCHCLASS       <>'GLOBAL'
    AND WEEKNAV.LAST_UNITS_OUTS<>'0'
    AND weeknav.weekend_dt      = '31 DEC 2013' -- NEED TO PASS THIS VALUE DYNAMICALLY
     --  AND WEEKNAV.SCHEME = 'DEC531D113'
    GROUP BY WEEKNAV.SCHEME,
      REPSAL.INFLOW,
      REPSAL.DIVIDEND,
      repsal.outflow,
      load.net_amount,
      income.profit,
      income.loss,
      appdepp.dec,
      appdepp.jan,
      income.dividend,
      income.interest,
      income.operating_expense,
      income.iie,
      income.dividend_expense,
      SCHEME.SCHEMETYPE,
load.value_date
    )
  GROUP BY scheme,
    AUM,
    SUBSCRIPTION,
    redemption,
    NET_PERFORMANCE,
    dividend,
    net_subscription,
    aum_postsubscription,
    profit_book,
    loss_booked,
    jan ,
    decm,
    inc_div,
    inc_int,
    ope_exp,
    iie,
    INC_DIV_EXP,SCHEME_TYPE,value_date;
 
